//
//  Day3.swift
//  AoC2021
//
//  Created by Ryan Vidal on 12/3/21.
//

import Foundation
import Algorithms

public let day3 = DailyPuzzleBase(solver: Day3Solver(),
                                       testInput: testInputString,
                                       puzzleInput: puzzleInputString)

public class Day3Solver: DailySolver {
    public typealias CalculationInput = [String]

    public func ParseInput(_ input: String) -> CalculationInput {
        return input.components(separatedBy: "\n")
    }

    public func PerformPart1Calculation(_ input: CalculationInput) -> Int? {
        return input.map { string -> Int in
            let left = string.dropLast(string.count/2)
            let right = string.dropFirst(string.count/2)

            for c in left {
                if right.contains(c) {
                    return value(of: c)
                }
            }
            fatalError()
        }.reduce(0, +)
    }

    public func PerformPart2Calculation(_ input: CalculationInput) -> Int? {
        return input
            .chunks(ofCount: 3)
            .map { group -> Int in
                let sortedGroups = group.sorted(by: { $0.count > $1.count })
                for c in sortedGroups.first! {
                    if sortedGroups.allSatisfy({ $0.contains(c) }) { return value(of: c) }
                }
                fatalError()
            }
            .reduce(0, +)
    }

    private func value(of c: Character) -> Int {
        switch c {
        case "a"..."z":
            return Int(c.asciiValue!) - Int(("a" as Character).asciiValue!) + 1
        case "A"..."Z":
            return Int(c.asciiValue!) - Int(("A" as Character).asciiValue!) + 27
        default:
            fatalError()
        }
    }
}

fileprivate let testInputString = """
vJrwpWtwJgWrhcsFMMfFFhFp
jqHRNqRjqzjGDLGLrsFMfFZSrLrFZsSL
PmmdzqPrVvPwwTWBwg
wMqvLMZHhHMvwLHjbvcjnnSBnvTQFn
ttgJtRGJQctTZtZT
CrZsJsPPZsGzwwsLwLmpwMDw
"""

fileprivate let puzzleInputString = """
gfWpjRRQffQGCHHJsGqjsj
SclzJZZvmmnPbJtVSqqNBqVCBdSCsd
tlbvZJDZtmtPcJmlPnhMFQWWpMRFTfLDRRTWRp
HjMPgSWjVrjgbHRRSSMRgjRdpdbGdlcdCvQfcCdlwQJfdf
LNDnhtNtLNFFZDtFnhzvdldDflvvDCdlJfldpJ
ZFLFZZmFtFtTNTSPRrVPWWMpRP
qLBSBLRwmgzqCbzCffDlrfCV
TFFFHNWFMFFMpHpGHMTHGNhrldWZCsdZsslZlZfrflDVss
PTMcPGntTThHhTGctnMvSwjjvmmqLBmnjqqgCR
nClJtMwwntqVVPJcgZqq
mjpsDcrcSSFFPZqFBWWgVP
vQcjsvhrvvrmhbmNHMNnlHbNMtCtNM
bgvvhnTQtjrrrhsDDf
pLSMltLzLLSjFrSSjrSJHD
zNWRLBdZPllPQtCvttgCqb
DRlDrrFTNDNlgzsGTBfcnqhhcnJfcrCSqc
MMmmdWtdLmvtldHjMmQfPBqSJWnfCCCqcWSSPJ
vjHMjLmjpLtHptQLmHvwTRgNVVpTzZFZgZRlsVTN
rzpMpDCGFCFFjRFsRPFRNFPv
fWclbHCHtSmfvjnmfsvZ
wTcTlSwwtQtWclBQBLGMLMCLVzVLwJGqLd
MQSjLNjPPLLSBPjfQhSPHjDVCjDtVVpDHwbwVpbD
RcmWzsRrzZrmTszWRqWlmRJscbtHwCbndCtcDVddDpdnVnbt
JTsrGGTqmwTlWmTzJzWmhhPLLGgPFgBffSSPhFFM
qMMRNZMDDNWLPqfzCgDcGncVDCgG
wwBFhwhhBgmcVzhghG
tbJbjjtJvwtdtwjpFtlbvtdTLNSMqNqMMgqNHPlZRTNggL
qmjMHsZmZSbjbZMjSLFFFFwgsgvFswpwww
hRJBhmnhhvFFwhcv
llfWDWzrzBNTRfNBrWzzTmZbGTMjPqMmZPjVbSZGSP
CRRPLwwcclcGVppQ
SHFjDjjHDTfSDNTTHfSHjQVGrpmllQQWltVVVZGp
HFlqzDTfqlzwbgPJLwCP
WRCNLphpLppSCWVHNfLRzVnQMnBnMddPMQDFQgrhPQFM
jTjJqvqjvPVJFJFBJF
qTsZbvGqqZlstsmZVljtwqwSHHNWczHSSRcWNSRHzzNfbW
glgzDzHjSrVHcVgbrjmNsscNGmNWssGNNtst
hHPQLHJpwdLpdHfQQtnZmNMwnZGZWwsFZM
QpdhPJRTJfPphJfhCBlVqVvgvVDBbvVqDbHD
VtHzjZpjVtHrprgGmjHsGHNdSJFQRcLJqCdQcSqJNpcq
bBWfTPwhbfDlMnhffRwQJQNdqJcLFQLSdR
bhBhvfMWTnlDnTBfPSmvmjsjmmGtzHtsHm
pcRPRPWrSDcJGZSStmwZZS
VnLfCfTlfVzfnMMBCqVNZJdtjNtJjhJdGNNbwT
BLvqCCMVsnRQsPQgDcZH
cQbqqQhDGhlQfQlhQrqGsTNgLgCpRgLTPPPLNbpg
wtHVddVFwSHznZwwznCpRBdjppNBNTTdCjRR
ZtWFwWtSmvVnwZDrCMGfQlDDJQmD
PzPZGCZzrZrlhdjdCqfCsqQdRD
cbvZLVVFvbbNSNFHSDnsDQdnfqNQDRngsR
FJHSLSFSScJJbWHFmFVFSZmrrzBmhtBwmzBMPMPzPh
nlpFcLBgcVcLbssGVBGGrlpGPhJJJJJqPBZPDNMQMJJhJQZZ
SSTjHzfHwtZSPVQVQMRQ
TzVHwWfTtzwdVzsbFnGgsbdcGrLc
FppVBRVZDdLmrDGmmfrQ
NtNMPNshJCzznLGJSrqRrRrr
tRssthhPlCWhPzsWtzhzCbVVjwTpVwdZZTpwjbdBbwBc
TTWblHWScvPCCHTWFzSrqqsNNSmdmqrrpz
RLRwjjnjZNprzmmZcq
QQgtQnccQDGjgLDRRcLthQhFBvCbMtMHTWlBFllBbFCMTW
WnBVNvDnVsNvZWdrWDLVDMbsHpTjpHCSSClsbSCCMH
GPFtmztzgPhRFtJTdbTwjppSCjpgSl
hJcfPtQhdtWNVZqNnqNQ
GLcqZPPsnqQcFsmBBrqRvrddNqrC
MtHthJwLllwvjRvvtrvBRS
VHMfDLbpfznszZQG
WBSdPlQPRfBtGQPfBGPBJgzgjwsJzsszJwCrdwCT
ZpppVpMVpnVHMVVbZRJrCgwRzTJrwNJw
MvhmnpLqLmhVmBlftRQBFSlR
hhQlSJqhtCSnqZJnqShSlNDwRzpvdwRlMBMMdcjRjMpMRc
frrGmLmWbfFrsmFHmBzBvBcwdJbvpjzbMM
mmgFrVGLWJLFGsgfhSVtVPqntqnnSStN
SFJTJTSqswwFQbwf
cDtcWPclrtPwVsfssQmN
HDtwWCgWdggdzSGJMSzGMq
JpqJtWRJMhCMJpMQCWtFrjgHdgdlgllwNjlQjldH
fBzPZcZvnBmDnZvZBZDmPvglVVVdgHHSwrNRgVgwNPRH
GbZnZccfvcsZmccsmnnZTRbCCMWFTWJqFCCMJFRT
vrrFqrFTBTmLmNrLMqMTHddJbHpWnhdWdWbHhJGM
wBzfwzcQSzWSSshpdWGp
gwjPPPDQtzQlzQDPqTgLBRmRqZBvqFNR
bWVptFFsbPcZsGLhsZGmLB
qnWrnrHdMCDCNqfWmvRRZSSRLdRGZGRG
nNqqNDfMrMWHDQNHzWfHNDnwzblpzFlbwtFbVVlwVcPJpP
BHJhlHdJQggvddglJBBhglhQzZHPZpFFPDMzFDDRDFZZDFZD
rSTfqnCffMfCVfCLNqbzbjWNDbbWDPFpPFbP
nfnnrSfCTVSwrqSLCGfTGlgQhlvsGMJQJBhhssJhGc
tBjjDjjqfDjLfJlrLgglvmrlmrcc
TwNNTVhwwpgvGSNNSssS
TbwhnvvChhbVRTPPRJBJQQfJttMQQJCQfW
mWSvSQVgmWQsQvspQJlrlLnJLLpCClhhlp
bFHRjZdNjjBZzFzhtnCllCcJLrCBll
HFFNHbdZZLZjfPFjHVQmWDDVsvsmTqVqDf
JJPllQQClqgBCgdHwHbpjVTwHd
tmGZtjGjHZpVbfMT
ShGjNGWmDSNcNRtGmshDRzzCvzQJJRBLrvlrBPJv
cTpqsTWqVVpsNLfvCDFlMFDVFL
JnndJPddQgzHlvMJFDhLCG
BjtntgdRnQgzjdBRQBlpNWrTTlNTSwNpWS
qHmqLVLjmVqsDBLtmjmbtPwCTwwPzGWRgGwGwMwW
ZhcCNCSprRTWTwSnWW
hflhZvvQhppZfcNpvrhpQHjVjLmbVmmVHVCFDvqVFb
nnNrwDnZrspwDNnZsNSDsNbCmpjvMTPQjLMmPmmQPGBTQP
FdVtRdRfctBQPmTtTLQB
qhzWVWJqVHwbhlLSsS
htWmhDhFztnztDhtBmBtghPRSrpfjVwPdfPwpwnRSVrr
cbCHvgJGcTqbqcbqqqcqsMsRVrSCwffdRPPpVpwCRSwfjj
GlgGQqTqbgQzttmBNNFz
NWQNQgdTgjQNddTZfrCQWRDnnnbqnLqnRcjJlqqvDj
FtSSmSmJhpllcclDvpln
JBVVSsSFBVBttShFGSPQfCGNdrMfZZTQTZNNdC
HgHthMhphcbfbMMfHhsGGDCRRVlcVSScsCRz
nWvPFqLqPNdjnNLnjdJnPdWjGlssDPSsllVCRzlTCTGlSDzS
RvddJRJQHwQwpZZb
gdZwgpjZZQtHTdrWrwdpWRnlhNBRlLbFthNhflhBnL
CVzDCPGMVqVmGsGGbJCmCDvMcRcqnBFFFnRBBNRBBNqhnFfF
DsmSGsGPzvMGJvdbgTSTbjbSSdgH
jBGmbNBQGdBNNDJNQRLLVDsHtDRzHHZZcH
wCWPFWPCrPhPrplvprhwpCHHtszttqZslRVHLtzVlJZL
vprMMvMnJCwnnPShNGSTfGSfNmmgdNff
bPtLbvVWWztbLSVVnbszpzQsrcDDBdpRcDrs
llZmgCZqgCFgmdRdJcscBdJsmQ
FZlgfqCFfgZHlqCMCglwCFGWntLLSMRSPGPVttWRtVGL
vtnDsDtrnrSvrMVmbrrJgPCmBm
FpQHzFclLVzWHhwHLQLlHLzPmMBQCJTdTmCTmBTJTTmgQg
pllcVWqlffZqZtZD
TSSZWpsQmZWcTZSvsTTTppNPzrBPrNBrzQNVFrBBNPqP
CgjmCbtGgftMmLtLmffzBzJJJNVVMNzNBqJrFN
gjgjLgtLwgbGjHdhhGdvmlnllnpWnplZvcvwTl
htLrRFRtbbhlGSLRtbJBJsjBmgMMgJgtmBzz
pZQWddQQfpZZffcDQZwddQwDMqDDsPgGJJzzjqzgJMBJgmms
QdcQTdwpGNwfrCRlRVlNLSbb
wrdvpVBVpMGPPjWjGZJJZT
tChCSlNfCCHtvHHWPHPZ
RbRRNvmcqcblfMwwdVBQQqqdpL
qcctqRcqmcHWzHBdDMZhfwthBnwt
JFsSNMSgNSNJJMGJBBdjhFDfhwhBrwnZ
TbgbsSgJMTJllblLCSPlsTCVQmRVVWpQzzqpqzVzHLQzcc
CVcWbjjSSCSSnpjWpCpprhHZlHtHGzHrZrHGclrl
gqZqdddLgmgNqvTGGHvvmrrGHT
FFDgZfZNLMgNfdDqDRnsnjBpbSbnMBBWpQpB
qwpQFwRnqFFfSBSfFt
LJJLGLWWtZlbgWHgGshhSdSVzmhHmfVzzC
lrbrbrNNJgDMLLbblGctvvvDqPcqctTTTcqP
vnblvbfHvlcHMlHlZbSPLTPLwCMBRRPRRFFR
tszzBqtzDsWVPRSmzLVmVL
tsNsDDNgGsqBrgBpgdHQbfhflcHdpZvdbh
cCpLtpGGLsgsppcpmGGHMtjfHRVhvvVVFRfhjV
NWnnnNNndQnQZdCdzzRVMHzvhhHWWWjj
CPJJrnSZpGDJLGTL
cnJzpcnmnQVFbzTlvTHBlb
tWCDPjfsDGfZhddhjjdTvFTgFgvbnFHvdHqT
hjfCjwDDGjPthsfhsnGNrJcQcRmJMLVJrJNMLw
CPPRrSlRccPcwTHwfdwTHdfl
mLQLLjhQhhQLZvpzssHDhdTswzzTJD
gmjbBvQLWmgbQZBCSRnnnSMVCBHnBS
sWrBJbsVqschzhQzHh
gtFmztnSlSfdlmnZSdSwcwGRTjcTcwwTcHccRg
FzFDzMZCdDZtCSrJVBMqWVrqNBqN
TvWlhhfhZJVgtSSl
ddBdGGdFmmBbdzqqPDDGGmdDZSgttHtZppSgzZHSgMhtMgtz
PGqdrbbbdPnrcjjhTRWLLc
trrmJWcrVwVbcPScdcBdGPHH
JTQnfjlJTpQFfMLlNJHHGDPdGsSdDjHGDPPH
ffFfnCTTCfTlplTMvNVzqWvwVzrrhwmWhJbW
hVtDtgcghzJpmmhlwp
srsnrqqsPqsBPvnqRBRMPbnwlplpmCStJwmzJPtJzJfwSw
bbrqjBbvGsjGGBWqMVFFVDNVNjZjgtgFgZ
mnmhBDHhwWCHsTgRsH
dcSlFvccMFMMFFggNsTzzvvzWnVW
llQdllZScFplJPpdcZSqBqjhmtnrwrDGnQGhrq
ZffVNgfTdmPVltsnnGwgQDnB
rMCFLMHpzCMFzHpzbrcHFLzBwsDsDDnlDBJrDDBBSJSnBn
MLMjMzqpCzvwqTmwZdvq
DDNlWPRqgPRPsRFjJQZbchJZbgQJ
zzrLLznpLbHnjcBHvVvHvJcZ
ndmrTzbMMTfzrTfnTLrzdpmsPPPqlqGDNNsPCRDRqRsD
zzdqTNfTfdfhgQhgqMFSjRDtDRWHqtWlwtqDRS
ssBCrcmpVGZvVRDdSDRwtmWdDb
rvGPCZLCVCPVBZFdnfThgNgLJNhf
bslcrssQwDPbQrrcsbsnQrjMLthPMMRhLRhLRgzmgPhRgM
DffvDfHGfNFdpfTdMtghLBThzVmBhBtM
SNvJNJdflDDbcDWJ
HFlHNpWsTlGWbFsGFTGHFLLNzPPhLVPMzVzMNPhhzP
jSvZtmrqqpcrCpPVzw
dddQvqDgDmjdSQQdqZjStpffWGgBRWTGfGsRlWBlHF
THnTbNrdBnLTHHnTnBrWRTndsccZsLZcDqmLDPcDlQDsmmsZ
ptwzzhpvGSVdqQlmszqmqPqc
wGVjSddCBggCHFWN
LFFbdbhhhvwvfTNdRhhRRvMbHDGjcfcGfDjtDHHcHqGjDqqj
WlQnVpWSSWWsPsgDqDzHDLHjJcttGP
rrWsZrgVnWrWSlmSlmSBFFbvTThhBFvvZLBhRw
BgBdcjThvjFcTggrqvVfzlnnPlrqLt
JpwJGPsQwpwSssHpPLlzlnNlzLLNNLVtsN
JPMmWGmWPmHbHpJbWGJmDmwbBTRZMBBdZCRTRjFjhCZCCBTT
BjbcLFRfBRhnbGjCVVvPllpcPtcDmdlPpvPP
WrMQqCNgsqWWsTNCMZMWWsWPvJDJDddvlpDtZDpDDDDwvP
qNMzzSzSQsGLbFCSCnVR
tTRpHJQpQBZcddhhMhvhJN
zswljflgMFbwPqmNmSdvShLNfLhm
qFbsMCVgsqMwRWHCWDDBDWpt
VSTCCWsJvGpHHCNC
GrqzZrrZjDljcDDlfjMqgRPfPvQPpBHNvHvBpvNQ
rljncDcznjMqhlhZDnltrzhTsGWtbVLFTTWGsbdWJdFTmL
mJPDSJJPZPJNrprSNrDmpZGrhFFhBqjGbGGVbFjhhfqBjBRV
cgnTQHdMQdTHdhqfggBhVqVfVS
nQdLLddssSJrmsNvZrPz
jfjffQzZQQMzZZfZZQFgjDWBCRlCBdTTBGGGRpBCgdhdBG
LrstWtNsbHLsprRBdlGpCwlh
HLnntbnscqLvvPNNfMWSSmDMDPjzjDzS
vhcGwWVvglltcfBn
BBSLrzSJLzJNJrLfPfPRsmDRmflD
jMjFZJNMqzrzZzFNFjNQqJzbCpBBvWdpvTCWhpVwdvHVCGbG
HlrnFmRmtRBQPVBTQHHQ
psSLJsLpTTdPdLTv
fCGgTgfSSCtRtFFzql
pfTpStppcDlWfbpDdzQRsQGJhfffQgJHzN
ZFZFZmBFwVwBVmLmLsRLRhHNzRLRNNzJ
FnnjwVPmnqqqjBjrTdblldCTpcPJtbTD
bdZHdWlrjslMMwGG
rDDTRBTqSqmJLBJRBTSJpmMsMMjhwvfMhjjfVGsLshhC
BqQFRPFRQBJgzrcZNHFdZt
wrDdLlDdPWZPTTrwlZpSsPsHVHsSCHnbzMHM
JtNFttNCjFvpppnMpJgSVS
NFFqFcCQCvfrZmGdZdmqrW
GMNNfJnNddJFJWsv
HSDwCmmghLmwmmHDpsvdFpMWpppptSbp
zCzBCgzhwmhzLrPnVrMqZBNfGf
DrHGtbltbCjjjffPrgsmzmcqsgDczdsmgJ
VZLwQLZLLVwLBQZnLVphhLQQqsTNmzJdcNTzzmJNqlNBsszz
wZLhVMplpQVRRlpVGPfjCjMGCrbHGWWb
BHpFrHHbBNTWWTWNhCPwPLNPjCdjLV
zJRRzJvZlcZsSMJdzSDjDtfDCtDtjDjjjj
dcJcszQJJGRJzRllMpGHpFTWmrTmBTbWWB
qnWWqhDhnjmjCMBlNRrfVfRNCB
vvBLBtGHJTHBddrNVJrVSVdr
BZLTHbgvHvTFBgTFFvhmWmmZDPmmZDsnqncs
WBvmjDbSzTMmHHdpNHNF
ttlflZRfGtfWVRltGtflCdHnJrNJHNHnJddNMNCnpF
VVwssWQQfRGZcszBQzDbjSBvSBDP
lSlQqQVqWWVWfqQWVJSTscdmPPwwTTmjjfpjPp
FCbzHbvHvtgrtFCvbvbbwdTwmsrwnTTpmdswmwcc
DtZbHdghztlLMQlWWhVQ
pqzzFSmdFqbQvlpdDGGrGBWPPBVNQnVttZ
cgcjwfBMhHCjjLMCrtcnPcsnsPGVnrVs
JgCChjjjBHhRRLLjjhplzvzpSFJvzzlDbSqm
mZzVQZMhmrffwfQhWhzmrmpBtRcdbnbcdcMpBbDbncdD
jsLTSlTWRBSDpnDn
GLTsGWGFsfmJGZVJZm
BGWshBGnsFWSLWBLlSSLWRJHnrVPrPcNHCNHctnPPJ
QmvQCqqMTZqvgmvTjpZCMgMtrVctPptHtrNVrptbJJbrRP
CzjCZfCwDzShDWdF
HmQlQHmJnpmptmzt
MTqMjMPvTvVvhpdztZnSwzwZqS
CcbLLPTMtCCsjHNHQFLRRFlRNN
GDFwLLLLSrbdPlFBMFsslFHmZH
TnJCgthHpVTfZMQZQmzWnZ
hjvtjtghtqJvVjhTgNhJTvdvdDDRbbccrwPdcGwrHS
MQQMBPzMGQBPBbDQPMhpnRwsGnRhNrFFpRnF
vmgHcmCTTlvvvZvTmqcTfmCRdddFnwdRdnVwFpVfpRnwNw
gvmqJTcHclCQJNzjMLWbLj
DbqqDDbQFqfNtZSLSq
RrdjPdmrpWBdmWRdccfLtNttSDMZBfftLMLf
dCcgmgRrWcgcppjCVVVVFHFnDnbJnb
fZMFfrtVdZSDVwTgjRMLhwTCLj
cNzPBNpclllzHbmTNRhqCRTgjC
nhhWJzhGPlQcGvsvfJtSfZfrtt
PSzrBWQBBGzBlnSnWtDrqHfNfwVwHcLNjHjwcDNmFH
hbRhtRCRpRvsRgVVVcNHNNNCwLwc
ZtRTRvttWWzBPlGZ
tcLnctNsJrWWNDTN
pwPPSjHSHHfzvmSvvvFVVGqGVqGmFqrDWgDr
pPSvfPQMzCQCSbhllLnQDhbtQZ
DmLffDhpVhjjVwvbwNVFbbNSNH
JRPBgMPRHBrMHMHqrBMqWJBSQQNbCvndNrdvCNCFwFrQnv
WcqJcPGMGtWRRBtgZjjspGHTLHGHTppm
ptJtWJpqRwDZZDVWpbDWqlvvflfMjlfCMjdCCdtslv
rLwTBGBzBBQTzmwCCjvdvlLllddsMl
NBwTmrGNgrTrcgPpWgWPDSVVPW
CdglMnrlSSqDPpcsZb
ccwmVJtvVvVtNhBpBFPDVpqbbD
TRGQjJjGTmtrTCgHWLfrcn
JNNhLwWwWQHNPDmmjHpc
zMqZCvVCSMVqMSTVvZVGsBnlslpmsmzlPmsHPsPB
qTVqrgdCCbhfHJQFtg
wNwCBBCZsfQWfmLCGSmmFRGSSF
zjnPHPVqMhhZLTcbpbSncp
lVlhlgzlPZlwtgBddJdfvf
JWRWRRLWJLnjtjnLzGzznflBvfPvPMqMDqdbzblCzC
TTScTVbHmTsVFrmcsgcHFlPMMvlvrDPdlrDDqdldvl
bVpcpchgsFZHbhSmSTsHFFjwtZjnjLttntNjLjNLWtjw
rffjPJzWzrgPpGWHVNqTtmqFTVRH
cswhvlLBvSLsCtbFccmqVFNTbb
wwZSCZSnCLsSDGgDmpGnfmmr
rTfJTNtjfNljlrWSlzRtNlTqsddwGnsnHHwwhssTsnqw
VpbpZZbvPLbZbbBhwqMHhsGMnJdVwV
mgQZJDLBJbbbcbgZClCSfWlrCjRjlDCR
fSpwcVfzsztcSSWNNMbnMRqTvtTv
mJFmGDDDhGhBJHCQddllqTvCllqTRRWNnMbT
FdFDGdDDDhhHdZDjhDmpwSPVZszpwZsVgsPRZs
"""
