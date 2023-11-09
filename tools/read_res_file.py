import json
import os.path


term_comp_problems = """PastaA1
PastaA10
PastaA4
PastaA5 
PastaA6
PastaA7
PastaA9
PastaB1
PastaB10
PastaB11
PastaB12
PastaB13
PastaB14
PastaB15
PastaB16
PastaB17
PastaB2
PastaB3
PastaB4
PastaB5
PastaB6
PastaB7
PastaB8
PastaC1
PastaC2 
PastaC3
PastaC5
PastaC7
PlusSwap
Round3 
CountUpRound
DivMinus
GCD5
LogBuiltIn
LogIterative
LogMult
McCarthyIterative
MinusBuiltIn"""
term_comp_problems = list(map(lambda x: x.strip(), term_comp_problems.split("\n")))


sv_comp_problems = """AliasDarteFeautrierGonnordSAS2010speedpldi4
ChawdharyCookGulwaniSagivYangESOP2008easy1
AliasDarteFeautrierGonnordSAS2010easy1
BradleyMannaSipmaCAV2005Fig1
LeikeHeizmannTACAS2014Ex7
AliasDarteFeautrierGonnordSAS2010easy21
ChenFlurMukhopadhyaySAS2012Ex210
ChenFlurMukhopadhyaySAS2012Ex308
Aviad
AliasDarteFeautrierGonnordSAS2010ndecr
GulavaniGulwaniCAV2008Fig1c
HeizmannHoenickeLeikePodelskiATVA2013Fig8
CookSeeZulegerTACAS2013Fig8a
Genady
HeizmannHoenickeLeikePodelskiATVA2013Fig9
ChenFlurMukhopadhyaySAS2012Ex219
ChenFlurMukhopadhyaySAS2012Ex207
LeikeHeizmannWST2014Ex9
ChawdharyCookGulwaniSagivYangESOP2008easy2
LeikeHeizmannTACAS2014Ex1
HeizmannHoenickeLeikePodelskiATVA2013Fig4
LeikeHeizmannTACAS2014Ex9
AliasDarteFeautrierGonnordSAS2010wise
AliasDarteFeautrierGonnordSAS2010easy22
ChenFlurMukhopadhyaySAS2012Ex213
ChenFlurMukhopadhyaySAS2012Ex301
HeizmannHoenickeLeikePodelskiATVA2013Fig1
PodelskiRybalchenkoTACAS2011Fig1
PodelskiRybalchenkoTACAS2011Fig2
AliasDarteFeautrierGonnordSAS2010speedFails4
HeizmannHoenickeLeikePodelskiATVA2013Fig5
NoriSharmaFSE2013Fig7
ChenFlurMukhopadhyaySAS2012Ex310
GopanRepsCAV2006Fig1a
ChenFlurMukhopadhyaySAS2012Ex304
MasseVMCAI2014Ex6
ChenFlurMukhopadhyaySAS2012Ex206
AliasDarteFeautrierGonnordSAS2010speedpldi2
ChenFlurMukhopadhyaySAS2012Ex307
AliasDarteFeautrierGonnordSAS2010speedpldi3
ChenFlurMukhopadhyaySAS2012Ex208
ChenFlurMukhopadhyaySAS2012Ex221
BrockschmidtCookFuhsCAV2013Introduction
AliasDarteFeautrierGonnordSAS2010terminate
PodelskiRybalchenkoVMCAI2004Ex2
HeizmannHoenickeLeikePodelskiATVA2013Fig2
GulavaniGulwaniCAV2008Fig1a
ChenFlurMukhopadhyaySAS2012Ex305
ChenFlurMukhopadhyaySAS2012Ex401
KroeningSharyginaTsitovichWintersteigerCAV2010Fig1
CookSeeZulegerTACAS2013Fig8b
MasseVMCAI2014Fig1a
ChenFlurMukhopadhyaySAS2012Ex216
AliasDarteFeautrierGonnordSAS2010cousot9
ChenFlurMukhopadhyaySAS2012Ex303
ColonSipmaTACAS2001Fig1
ChenFlurMukhopadhyaySAS2012Fig1
NoriSharmaFSE2013Fig8
ChenFlurMukhopadhyaySAS2012Ex218
ChenFlurMukhopadhyaySAS2012Ex209
LarrazOliverasRodriguezCarbonellRubioFMCAD2013Fig1
UrbanWST2013Fig2
AliasDarteFeautrierGonnordSAS2010wcet2
BrockschmidtCookFuhsCAV2013Fig9a
AliasDarteFeautrierGonnordSAS2010complex
AliasDarteFeautrierGonnordSAS2010while2
AliasDarteFeautrierGonnordSAS2010loops
PodelskiRybalchenkoLICS2004Fig1
BrockschmidtCookFuhsCAV2013Fig1
ChenFlurMukhopadhyaySAS2012Ex201
LeikeHeizmannTACAS2014Fig1
ChenFlurMukhopadhyaySAS2012Ex101"""

sv_comp_problems = list(map(lambda x: x.strip(), sv_comp_problems.split("\n")))

nu_term_problems = """DynamiteEx2Vars
DynamiteExample
DynamiteExampleX4
DynExUpTo2VarsConj
DynExUpTo2VarsDisj
DynExUpTo3VarsDisj
DynExUpTo4VarsDisj
MultDisj
Poly2VarsCondBreak
PolyClosingIn
Square2VarsDisj
SquareDisj2Vars
TwoPol4VarsConj
TwoPol4VarsDisj"""

nu_term_problems = list(map(lambda x: x.strip(), nu_term_problems.split("\n")))


def in_nuterm(l):
    return list(filter(lambda x: x in nu_term_problems, l))


def in_sv_comp(l):
    return list(filter(lambda x: x in sv_comp_problems, l))


def in_term_comp(l):
    return list(filter(lambda x: x in term_comp_problems, l))


results = "../../cleaned_sygus_benchmarks/experiment_results_rankings.json"

data = None
with open(results, "r") as f:
    data = json.load(f)["iterations"]

solved = []
for it in data:
    solved = solved + [list(map(lambda x: os.path.basename(x["problem"])[:-21], it["successful"]))]

for idx, s in enumerate(solved):
    print("iteration: ", idx, "TermComp:", len(in_term_comp(s)), "SVCOMP:", len(in_sv_comp(s)), "nuterm:", len(in_nuterm(s)), "Total:", len(s))
    print(in_term_comp(s))