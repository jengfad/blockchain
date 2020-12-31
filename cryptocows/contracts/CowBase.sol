// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

contract CowBase {
    struct Cow {
        uint8[7] traits;
        uint256 motherId;
        uint256 fatherId;
    }

    mapping(uint8 => string) private _traitMap;
    uint8 private _traitMapLength = 7;

    Cow[] public cows;
    mapping(uint256 => address) public cowIndexToOwner;

    constructor() {
        _getTraitIndexMapping();
    }

    function _hasValidParents(uint256 motherId, uint256 fatherId)
        private
        returns (bool)
    {
        return motherId != fatherId;
    }

    function _getRandomTrait(string memory traitKey) private returns (uint8) {
        return
            uint8(
                uint256(
                    keccak256(
                        abi.encodePacked(
                            block.timestamp,
                            block.difficulty,
                            msg.sender,
                            traitKey
                        )
                    )
                ) % 10
            );
    }

    function createCow() public {
        uint8[7] memory newTraits = _getRandomTraits();
        uint256 cowId = cows.length;

        Cow memory newCow = Cow({motherId: 0, fatherId: 0, traits: newTraits});

        cows.push(newCow);
        cowIndexToOwner[cowId] = msg.sender;
    }

    function breedCow(uint256 motherId, uint256 fatherId) public {
        require(_hasValidParents(motherId, fatherId));
        uint8[7] memory combinedTraits = _getCombinedTraits(motherId, fatherId);
        uint256 cowId = cows.length;
        Cow memory newCow =
            Cow({
                motherId: motherId,
                fatherId: fatherId,
                traits: combinedTraits
            });

        cows.push(newCow);
        cowIndexToOwner[cowId] = msg.sender;
    }

    function _getCombinedTraits(uint256 motherId, uint256 fatherId)
        private
        returns (uint8[7] memory)
    {
        uint8[7] memory motherTraits = cows[motherId].traits;
        uint8[7] memory fatherTraits = cows[fatherId].traits;
        uint8[7] memory shuffledTraits = _getShuffledTraits();
        uint8[7] memory childTraits;

        // first 2 traits from mother
        childTraits[shuffledTraits[0]] = motherTraits[shuffledTraits[0]];
        childTraits[shuffledTraits[1]] = motherTraits[shuffledTraits[1]];

        // next 2 traits from father
        childTraits[shuffledTraits[2]] = fatherTraits[shuffledTraits[2]];
        childTraits[shuffledTraits[3]] = fatherTraits[shuffledTraits[3]];

        // randomize last 3 traits
        childTraits[shuffledTraits[4]] = _getRandomTrait(
            _traitMap[shuffledTraits[4]]
        );
        childTraits[shuffledTraits[5]] = _getRandomTrait(
            _traitMap[shuffledTraits[5]]
        );
        childTraits[shuffledTraits[6]] = _getRandomTrait(
            _traitMap[shuffledTraits[6]]
        );

        return childTraits;
    }

    function getCowtraits(uint256 cowId) public returns (uint8[7] memory) {
        Cow memory cow = cows[cowId];
        return cow.traits;
    }

    function _getRandomTraits() private returns (uint8[7] memory) {
        return [
            _getRandomTrait(_traitMap[0]),
            _getRandomTrait(_traitMap[1]),
            _getRandomTrait(_traitMap[2]),
            _getRandomTrait(_traitMap[3]),
            _getRandomTrait(_traitMap[4]),
            _getRandomTrait(_traitMap[5]),
            _getRandomTrait(_traitMap[6])
        ];
    }

    function _getShuffledTraits() private returns (uint8[7] memory) {
        uint8[7] memory traitIndexes = [0, 1, 2, 3, 4, 5, 6];

        for (uint8 i = 0; i < traitIndexes.length; i++) {
            uint8 n =
                i +
                    uint8(
                        (uint256(
                            keccak256(
                                abi.encodePacked(
                                    block.timestamp,
                                    block.difficulty,
                                    msg.sender
                                )
                            )
                        ) % (traitIndexes.length - i))
                    );
            uint8 temp = traitIndexes[n];
            traitIndexes[n] = traitIndexes[i];
            traitIndexes[i] = temp;
        }

        return traitIndexes;
    }

    function _getRandomTraitIndex(uint8 index) private returns (uint8) {
        return
            uint8(
                uint256(
                    keccak256(
                        abi.encodePacked(
                            block.timestamp,
                            block.difficulty,
                            msg.sender,
                            index
                        )
                    )
                ) % 7
            );
    }

    function _getTraitIndexMapping() private {
        _traitMap[0] = "baseColor";
        _traitMap[1] = "eyes";
        _traitMap[2] = "eyeColor";
        _traitMap[3] = "hair";
        _traitMap[4] = "mouth";
        _traitMap[5] = "pattern";
        _traitMap[6] = "patternColor";
    }
}
