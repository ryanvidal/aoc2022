//
//  Day6.swift
//  AoC2021
//
//  Created by Ryan Vidal on 12/6/21.
//

import Foundation

public let day6 = DailyPuzzleBase(solver: Day6Solver(),
                                       testInput: testInputString,
                                       puzzleInput: puzzleInputString)

public class Day6Solver: DailySolver {
    public typealias CalculationInput = String

    public func ParseInput(_ input: String) -> CalculationInput {
        return input
    }

    public func PerformPart1Calculation(_ input: CalculationInput) -> Int? {
        return CommunicationSystem.startOfPacket(for: input)
    }

    public func PerformPart2Calculation(_ input: CalculationInput) -> Int? {
        return CommunicationSystem.startOfMessage(for: input)
    }
}

public struct CommunicationSystem {
    static public func startOfPacket(for message: String) -> Int? {
        return firstIndex(after: 4, for: message)
    }

    static public func startOfMessage(for message: String) -> Int? {
        return firstIndex(after: 14, for: message)
    }

    static private func firstIndex(after uniques: Int, for message: String) -> Int? {
        // Initial solution:
//        for index in message.indices {
//            let endIndex = message.index(index, offsetBy: uniques - 1)
//            guard endIndex < message.endIndex else { fatalError() }
//
//            let chunk = message[index...endIndex]
//            if Set(chunk).count == uniques {
//                return message.distance(
//                    from: message.startIndex,
//                    to: message.index(index, offsetBy: uniques)
//                )
//            }
//        }
//        return nil

        // Algorithms solution:
        for (index, window) in message.windows(ofCount: uniques).enumerated() {
            if Set(window).count == uniques { return index + uniques }
        }
        return nil
    }
}

fileprivate let testInputString = "mjqjpqmgbljsphdztnvjfqwrcgsmlb"

fileprivate let puzzleInputString = "rvnvzvhzzjgjgffclllnhhtltptgptgpttjhttsllmbbphbpbzpbpjjcwjwqwccnrrtvrtrfrwffnqffsggwzzhtzhthqhffmrrzsrrnrtrqqbllhrlrjrvvrvvgdgjgfjjtzznffrfvfggswgssccpcwpccstcsstwssgzssswsgwsgsnsshcsscsffcwcmmhmsmrsrddwhhszsfsjfsfccwssvdssmzzwrzzjfzzvzzfsfsvshschhvlhhvmvpvhhstsdtstgtrrtjjcssgfssnsnfsnscnsslvvqbbhthqtqzqmzmjjfmmbdmmzdmdpmpnnfjnnrwnwbwrrwjrrttfzzlwwfmmnhhqlhqqbnqnqznncmmhfmfftsfszssftstggppfddtztltctqcqjcqcmclcnccdgcggvmvvcsstztbzttsccmgcghcczfzszbzmbmjjggsqgghbhjjhhrrjljmllczlzzqssjfjqfjfmfdfgffczfzwwpfwpwbbftbffplphhfcftctlcclhlnlhnhlhnhqnhhjbjmmtpmmlsmllvhhjghhmzzwpzprrjrzzvrvcvqvssgssnccmgmppfhfwhhczhhprhrffpvvqrqvqccdhdvvvssvdvwdwwzggfvfnvvqvwwzwmzzvttgzzwjjfvvpvffqpqhqrrwccjbjppbzbrbrrphrhgrhhzbbhrrblbjjznnlccsffpcfpcfpfddfwddbffczztzsttzsstddrqdqqchqccrlccfcwwghwhnhbhjbhhzrrgprrftrffqlljlslggzdzvvrgvgcgnnngtnggdcgddhjhchqcqfqwfwjffqppblbddgmdgmddrnddjtdjttgzgpzggwvwjvwwhdwwbvvtftcfttpftpfpzfznnchnhrrdtdbtdbdppsjsgsttptsptssnwntwnnsshqqgnnqnddhjjtqqjhhmghmhmsstrrhmmwvvlssprsrbbswsddbnntmtbmtbmmtmrrffvjffdrffnttbffbccgchghjgjwwshwswdswdsdsrdsdjdvjjgbjbssptpddzbdddqdpdspswssjrjwwcbbvsspnspslpplzlqlccvlvfllntlntnqnrqnqpqlqflfrfsfgsfswwptwwgqggrhghzghhrthtzhzsswhhzffpsffhnnrvnrvvhmmlvvqsslddhcddsllpmpggrhrcrbbmnmjmqmlmpmrrqwqhqrqhrrgrqqsrrpjpdjppzhphthddlzdzhddjvdjdcjcncnvnzzvwzvzgzjggcllvpllgdgqqdvvwnvwvwqqvwvvrbbtqqwhdztqfzzcqrshjzwqnpdsshmpjzwqdptbvfqzmfnbtlgbbsjbqgnblhbbpsfdzvcmpzfwczcnbdndsjzccjcqnrdglwfrvwtnjwpvpvvgwtmnpzhbwnbqwznmdvdrsjnlsfrpcnhlbmlgmrcjbbvhqnvbrmlnfttjllstqnqqnhqrzrhfqjbfbwfhhjzwtwzjmszzhjnjbhrlbnnpfvdmlftjnfsfnvddqfhqqlljrthptvmhbqrdmdcmljwgbrqrjwcrtmvjgqtblnslgbjmdsrrpgfsctrhwlwnszpljhrfnsfpcsgczzltgsztclhgcqljrcmbbpdlztncnrnrmgrttplcnldfqddqhznmcczbmwvsztmwmcqnrzmlmqchnhnhrrhhfntjzqcbnttspptqwvphlbtpfcbhdqzbhsbvhmsqbsdntwpcrnzvmbgqsgttbqhhblfjpmvfcrzhfnzwrzbzgsdfqndzzhfdnrvsnvfbptthjnhgljhrvwwrlbnfpvvjdjchcgbhfrqvszhrhqvtzplwsptvdhqwlzhcjpclmmrlccvgvtgsfpnjhqhrbqglznpdhmsqwwsbmhmlsmmvvghsmplqjchrfctltmnqnddzqjfpljwljbdqjcqdqzwsbcclqsmsmlstvljwwtfmpnhqzqfjghjfchjccqrchsvngvrnwfwttsnvrdlfvwfptsjcpslvvpmjclfcpljqjszptsgsmntzrdjbgrzmgvzddqrlsndjzzqbznqnphbnwfhtjjlwjpsvffrdrbsbttpgrvmqrdndqvlgzcpfbttvqdgvrmtvfclcbcwllthmdzjcflwpnrsqzrjdzbvqgzsqvjjpjjpnjtcjqhcfbjdqndlcwzhcbjtgtlvtdwctdnqcbcgsmrcrmwjntdwbjdbzmshbvlspjfdbvmlrbdzlmlggthvphnrqlrcdsqpsgqcmpgmgdzvdqlmcldvztpsbmpwjgjfhswplwrvwpbwbsgsvlhdvmpzwnnbwjwmshwcnqfqjdpchfjjcbdnslqchhnznpqpnnctznbtccclgjhmnngdjlmqnzpsdptqqcrblmrlnnpgvrfrtmbjnmspfrbwpclhgtbsghndrjfbggsplvcjnhjjbqzsfdpfnvchzjgbhdqgddfgddvzdcrjlntnsmscqwmpptqgbnvtsvpjvmhcfpbfrpzqbpfhlbjrmbmvdvvnvfqsndglvhfrqcsbsbbprscrbfthzcwcdrprqrwjzwrpblfllpwzlhmqvltjgpcjzpzwbltgwsrgrrhzcqfpvhcprdhnzcfphqrwcvtpcbppjwzmmwjhbvwbblnbwvcqzvlfzjhgmlnhlhrbsplfctggfbhbgwpncznvtmdtqqmjsvsnrlqswzvflrfsncgpdcndlwrfrqwqnqtjmsphwsgzhdjpnsdgrbrfhbfdrntwvgvbwnvwnrmdbhqgrglbfwprflnrljrwsgwtpgtmfhvvghtzndvwlzjchhmlwcncmpvrslrglzjcnhfdqhcrljhgbzpssvdnmfwzstmvrztgpsscfswltnbwrrtcnvbswmmjbmnnnvqwjzhprfnvlbvzzdvbwlwchrvqnwwpbnttbhfdvjjvzsznhczjcncmcrmwtrlsvbwpsrcwqdvgcfjsbqnwmjmtcgpnmcbfbcqhzrjbtlpvwzhjqqprbdnbgzfwlprlcspwjwnfftldqzbcgqnjtglvbpqffdvjbpslqcdzwdnmncvcwfshdhsmssttqfrsbnjgmhfqzlgrbpdfqtfdwslsgphfzzgbzjssfbgnwztzmczplqwjmhtlflpvqqqmrvlllhngtfgsvbbnvhzqbcgpmnlsmpwqwgqfjpzplzjhrslwzrsrgjgpppjlnhrnggcdzvspsztnschnqftgffbtvrpzndzpqmtsfmwgnrvpmtgpvnmqfmwgcvlznwqnjnjwpgnqfjwtdhhmztlvlcvrlzmlpmjdvdnzwbfsshfsvbbhqsmphjhqtlnvlsmvwlqvfqpnjnzlgmdvwzzrllmcgwtqdwphhbwmlrqhqrfmdvtqswvsllqvwmfbbpllsbjbvgsmrcgqvfgsnszfrdlcjbtfgcbclhmzlmqlnhmslcmgrcvjjlbpsjjcznzqwmztcgdgbmrlgwzjzzjrpndfrdzztzzgmsrcnwrvqrdcczrbhdpfjwvqsmbrcvllvjrrbrsqnzldltdgzscjrssvdhzhnvltpgfdfcvfbtqmphdzhpzgjhjbwsmdlbqqgcrhjrwhgvfgdllmmlnpsbtvdrrzmltfwgrcsfrrsdbdmjtrwhnlgcrgjgmbzvzvqbflvbrsqcssjgsvpjmlhtcggzwbvddmwwtfdrlltjqcpwnthczzlzdszvtmrmhbpcgstvrsnmbdcmjzsvnncmgmlnrzzhfvmblgptwwwbrmtcczjwcqmvdrsvfjgqqvghnhbntqcdrppfmvdzbcjvztrnpdhmdpmnvsnzzldvdfqbdrwqqqqsmswthwpjwdrflszbspqhpfwztjjcbdsrftdsrsfdltnfztcslmbsghgrtcscrfmptqplwpmtqdzthgfjhbqdnsffrpjmgczmrlfvzcjttwtmtqfbtlqrttvjdwhfgcgcclrlswmzhzbfhjrggnhwtnffnqqcvldlttvvgrbcqbmqzvtflfmdblhdbzphrqtbshvp"
