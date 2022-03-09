/* 
Copyright (c) 2021 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct Data : Codable {
	let sectors : [Sectors]?
	let logos : [Logos]?
	let popup : Popup?
	let type : String?
	let recomandtion : [Recomandtion]?
	let guide : [Guide]?
	let stock : [Stock]?
	let news : [News]?
	let store : [Store]?

	enum CodingKeys: String, CodingKey {

		case sectors = "sectors"
		case logos = "logos"
		case popup = "popup"
		case type = "type"
		case recomandtion = "recomandtion"
		case guide = "guide"
		case stock = "stock"
		case news = "news"
		case store = "store"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		sectors = try values.decodeIfPresent([Sectors].self, forKey: .sectors)
		logos = try values.decodeIfPresent([Logos].self, forKey: .logos)
		popup = try values.decodeIfPresent(Popup.self, forKey: .popup)
		type = try values.decodeIfPresent(String.self, forKey: .type)
		recomandtion = try values.decodeIfPresent([Recomandtion].self, forKey: .recomandtion)
		guide = try values.decodeIfPresent([Guide].self, forKey: .guide)
		stock = try values.decodeIfPresent([Stock].self, forKey: .stock)
		news = try values.decodeIfPresent([News].self, forKey: .news)
		store = try values.decodeIfPresent([Store].self, forKey: .store)
	}

}