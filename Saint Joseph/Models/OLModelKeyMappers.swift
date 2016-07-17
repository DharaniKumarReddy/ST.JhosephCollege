//
//  OLModelKeyMappers.swift
//  Saint Joseph
//
//  Created by Dharani on 7/15/16.
//  Copyright © 2016 Dharani. All rights reserved.
//

import Foundation

/**
 If a property is mapped to a variable with the same name with an underscore that means there is a custom
 read only method that is used to reduce the need for repeated casting to make code more readable.
 
 For ex: responses is mapped to _responses and a "responses" read-only var in Swift casts the return value to [OLResponse]
 
 In some cases name the swift read-only method has been renamed to clarify the variable.
 For ex: optional_actions is mapped to _optionalActions here but in the .swift extension it is mapped to
 the optionalGoalActions method to clarify the fact that it is an object of type OLGoalAction
 
 - Also note If a mapping is applied, then any variables with underscores have to be mapped manually
 since the automatic snake_case to camelCase is not applied by JSONModel
 
 For the case of assignment the underscored _var needs to be used. If a custom set { } method is added on the
 read-only var, then JSONModel throws an error.
 */

extension OLNewsFeed {
    override public class func keyMapper() -> JSONKeyMapper {
        return JSONKeyMapper(dictionary: [
            "sjec_news" : "news"
            ])
    }
}

extension OLNews {
    override public class func keyMapper() -> JSONKeyMapper {
        return JSONKeyMapper(dictionary: [
            "description" : "descript",
            "updated_at" : "updatedAt",
            "s_img" : "smallImageURL",
            "l_img" : "largeImageURL"
            ])
    }
}

extension OLGallery {
    override public class func keyMapper() -> JSONKeyMapper {
        return JSONKeyMapper(dictionary: [
            "sjec_images" : "gallery"
            ])
    }
}

extension OLImageItem {
    override public class func keyMapper() -> JSONKeyMapper {
        return JSONKeyMapper(dictionary: [
            "img:" : "imgURL"
            ])
    }
}




