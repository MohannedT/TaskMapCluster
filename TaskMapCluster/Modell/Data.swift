/* 
Copyright (c) 2020 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct LocationData : Codable {
	let image : String?
	let id : String?
    
	let name : String?
	let latitude : String?
	let longitude : String?
    
	let addressOne : String?
	let addressTwo : String?
	let state : String?
	let country : String?
	let userLocation : String?
	let companyType : String?
	let category : String?
	let newJoined : Bool?

	enum CodingKeys: String, CodingKey {

		case image = "image"
		case id = "id"
		case name = "name"
		case latitude = "latitude"
		case longitude = "longitude"
		case addressOne = "addressOne"
		case addressTwo = "addressTwo"
		case state = "state"
		case country = "country"
		case userLocation = "userLocation"
		case companyType = "companyType"
		case category = "category"
		case newJoined = "newJoined"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		image = try values.decodeIfPresent(String.self, forKey: .image)
		id = try values.decodeIfPresent(String.self, forKey: .id)
		name = try values.decodeIfPresent(String.self, forKey: .name)
		latitude = try values.decodeIfPresent(String.self, forKey: .latitude)
		longitude = try values.decodeIfPresent(String.self, forKey: .longitude)
		addressOne = try values.decodeIfPresent(String.self, forKey: .addressOne)
		addressTwo = try values.decodeIfPresent(String.self, forKey: .addressTwo)
		state = try values.decodeIfPresent(String.self, forKey: .state)
		country = try values.decodeIfPresent(String.self, forKey: .country)
		userLocation = try values.decodeIfPresent(String.self, forKey: .userLocation)
		companyType = try values.decodeIfPresent(String.self, forKey: .companyType)
		category = try values.decodeIfPresent(String.self, forKey: .category)
		newJoined = try values.decodeIfPresent(Bool.self, forKey: .newJoined)
	}

}
