#import "PokemonStoreTests.h"
#import "PokemonStore.h"

@implementation PokemonStoreTests

-(void) setup {
    [[PokemonStore instance] load];
}

- (void)testLoadsPokemonDataFromFile {
    NSDictionary *data = [PokemonStore instance].pokemonTypeMap;
    XCTAssertEqual([data count], (NSUInteger) 717);

    NSArray *types = @[@"fire", @"flying"];
    XCTAssertEqualObjects(types, [[PokemonStore instance] typesFor:@"Charizard"]);
    XCTAssertEqualObjects([[PokemonStore instance] names][0], @"Abomasnow");
}

- (void)testFiltersPokemonNames {
    NSArray *filteredList = [[PokemonStore instance] namesMatching:@"Mime"];
    NSArray *expected = @[@"Mime Jr"];
    XCTAssertEqualObjects(filteredList, expected);
    XCTAssertEqual([[[PokemonStore instance] namesMatching:@""] count], (NSUInteger) 717);
}

- (void)testFiltersCaseInsensitive {
    NSArray *filteredList = [[PokemonStore instance] namesMatching:@"abra"];
    XCTAssertTrue([filteredList containsObject:@"Abra"]);
}

@end