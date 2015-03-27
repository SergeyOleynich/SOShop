//
//  SOProduct.m
//  SOShop
//
//  Created by Sergey on 21.02.15.
//  Copyright (c) 2015 Sergey. All rights reserved.
//

#import "SOProduct.h"

#define kNameKey @"name"
#define kCostKey @"cost"
#define kIdKey @"id"
#define kBarCodeKey @"barCode"
#define kDimensionKey @"dimension"
#define kSaleKey @"sale"
#define kDescriptionRusKey @"descriptionRus"
#define kDescriptionEngKey @"descriptionEng"
#define kURLKey @"urlToImage"

@implementation SOProduct

-(instancetype)initWithName:(NSString *)name cost:(NSNumber *)cost barCode:(NSNumber *)productBarCode dimension:(NSString *)dimension {
    
    self = [super init];
    
    if (self) {
        _name = NSLocalizedString(name, nil);
        _cost = cost;
        _barCode = productBarCode;
        _dimension = NSLocalizedString(dimension, nil);
    }
    
    return self;
    
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    
    self = [super init];
    if (self) {
        _name = [dictionary objectForKey:@"title"];
        _cost = [dictionary objectForKey:@"cost"];
        _productId = @([[NSUserDefaults standardUserDefaults] integerForKey:@"productId"] + 1);
        [[NSUserDefaults standardUserDefaults] setInteger:[self.productId integerValue] forKey:@"productId"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        _barCode = [dictionary objectForKey:@"barCode"];
        _dimension = [dictionary objectForKey:@"dimension"];
        _sale = [dictionary objectForKey:@"sale"];
        _descriptionRus = [dictionary objectForKey:@"descriptionRus"];
        _descriptionEng = [dictionary objectForKey:@"descriptionEng"];
        _urlToImage = [NSURL URLWithString:[dictionary objectForKey:@"image"]];
    }
    return self;
}

#pragma mark - NSCoping

- (id)copyWithZone:(NSZone *)zone {
    SOProduct *product = [[[self class] allocWithZone:zone] init];
    product -> _name = [_name copyWithZone:zone];
    product -> _cost = [_cost copyWithZone:zone];
    product -> _productId = [_productId copyWithZone:zone];
    product -> _barCode = [_barCode copyWithZone:zone];
    product -> _dimension = [_dimension copyWithZone:zone];
    product -> _sale = [_sale copyWithZone:zone];
    product -> _descriptionEng = [_descriptionEng copyWithZone:zone];
    product -> _descriptionRus = [_descriptionRus copyWithZone:zone];
    product -> _urlToImage = [_urlToImage copyWithZone:zone];
    return product;
}

#pragma mark - NSCoding

- (void)encodeWithCoder:(NSCoder *)aCoder {
    
    [aCoder encodeObject:_name forKey:kNameKey];
    [aCoder encodeObject:_cost forKey:kCostKey];
    [aCoder encodeObject:_productId forKey:kIdKey];
    [aCoder encodeObject:_barCode forKey:kBarCodeKey];
    [aCoder encodeObject:_dimension forKey:kDimensionKey];
    [aCoder encodeObject:_sale forKey:kSaleKey];
    [aCoder encodeObject:_descriptionEng forKey:kDescriptionEngKey];
    [aCoder encodeObject:_descriptionRus forKey:kDescriptionRusKey];
    [aCoder encodeObject:_urlToImage forKey:kURLKey];
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self) {
        _name = [aDecoder decodeObjectForKey:kNameKey];
        _cost = [aDecoder decodeObjectForKey:kCostKey];
        _productId = [aDecoder decodeObjectForKey:kIdKey];
        _barCode = [aDecoder decodeObjectForKey:kBarCodeKey];
        _dimension = [aDecoder decodeObjectForKey:kDimensionKey];
        _sale = [aDecoder decodeObjectForKey:kSaleKey];
        _descriptionRus = [aDecoder decodeObjectForKey:kDescriptionRusKey];
        _descriptionEng = [aDecoder decodeObjectForKey:kDescriptionEngKey];
        _urlToImage = [aDecoder decodeObjectForKey:kURLKey];
    }
    return self;
}

-(NSString *)description {
    return [NSString stringWithFormat:
            @"\nname: %@\ncost: %@\nid: %@\nbarCode: %@\ndimension: %@\nsale: %@\ndescriptionRus: %@\ndescriptionEng: %@\nurlToImage: %@", self.name, self.cost, self.productId, self.barCode, self.dimension, self.sale, self.descriptionRus, self.descriptionEng, self.urlToImage.absoluteString];
}

@end
