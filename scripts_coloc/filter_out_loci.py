import gzip

loci = '''
rs3844006   6   132095002  novel
rs2854746   7   45960645   novel
rs10899970  10  44515716   novel
rs9633535   10  63836088   novel
rs10762577  10  75917431   novel
rs11063120  12  4486618    novel
rs9515203   13  111049623  novel
rs7182103   15  79123946   novel
rs10456561  6   12887465   known
rs35355695  6   12891103   known
rs9349379   6   12903957   known
rs10811650  9   22067593   known
rs72652478  9   22102043   known
rs62555371  9   22107238   known
rs4977575   9   22124744   known
rs7412      19  45412079   known
'''.strip().splitlines()
loci = [dict(zip('locus chr pos cls'.split(), locus.split())) for locus in loci]
for locus in loci:
    locus['pos'] = int(locus['pos'])

fn_ea = '/hpc/dhl_ec/data/_gwas_datasets/_CHARGE_CAC/CAC1000G_EA_FINAL_FULL.txt.gz'
fn_aa = '/hpc/dhl_ec/data/_gwas_datasets/_CHARGE_CAC/METAL.AA.Filtered.18Mar16.txt.gz'

def read_gwas(fn, select, selecth=dict(
    chr=str, pos=int, rsid=str, a1=str.upper, a2=str.upper, f1=float, beta=float, se=float, p=float, n=int)):
    with gzip.open(fn, 'rt') as f:
        header = next(f).split()
        i = 1
        for line in f:
            row = line.split()
            row = dict(zip(header, row))
            try:
                row = {k: f(row[v]) for (k, f), v in zip(selecth.items(), select)}
            except:
                print(row)
                raise
            row['line'] = i
            yield row
            i += 1

def filter_row(row, window=250000):
    for locus in loci:
        if locus['chr'] != row['chr']:
            continue
        d = abs(locus['pos'] - row['pos'])
        if d > window:
            continue
        out = dict(
                locus=locus['locus'],
                locuschr=locus['chr'],
                locusbp=locus['pos'],
                locuscls=locus['cls'],
                distance=d
                )
        out.update(row)
        yield out

def filter_gwas(gwas, window=250000):
    for row in gwas:
        yield from filter_row(row, window=window)

ea = read_gwas(fn_ea, ['Chr', 'Pos', 'rsID', 'Allele1', 'Allele2', 'Freq1', 'Effect', 'StdErr', 'Pvalue', 'N'])
aa = read_gwas(fn_aa, ['chr_vcf', 'position_vcf', 'SNPID4', 'Allele1', 'Allele2', 'Freq1', 'Effect', 'StdErr', 'P.value', 'N'])

with open('ea.filt', 'w') as f:
    fst = True
    for hit, row in enumerate(filter_gwas(ea)):
        if fst:
            print(*row.keys(), file=f)
            fst = False
        print(*row.values(), file=f)

with open('aa.filt', 'w') as f:
    fst = True
    for hit, row in enumerate(filter_gwas(aa)):
        if fst:
            print(*row.keys(), file=f)
            fst = False
        print(*row.values(), file=f)

