.PHONY: setup-cabal clean run

BUILD = HashTablesPerformance
TEST_FILES = large-file.txt indexes.txt

all: $(BUILD) $(TEST_FILES)

$(BUILD): .cabal-sandbox HashTablesPerformance.hs
	ghc -package-db=./.cabal-sandbox/x86_64-osx-ghc-7.6.3-packages.conf.d -O3 -main-is $(BUILD).main --make $(BUILD).hs

.cabal-sandbox:
	cabal update
	cabal sandbox init
	cabal install hashtables criterion

setup-cabal: .cabal-sandbox

$(TEST_FILES):
	runghc -package-db=./.cabal-sandbox/x86_64-osx-ghc-7.6.3-packages.conf.d GenerateFiles.hs

run:
	./$(BUILD)

clean:
	rm -f $(BUILD) $(BUILD).o $(BUILD).hi
