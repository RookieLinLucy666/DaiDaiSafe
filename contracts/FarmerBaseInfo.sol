pragma solidity>=0.4.24 <0.6.11;
pragma experimental ABIEncoderV2;

import "./Table.sol";

contract FarmerBaseInfo {
    struct FarmerBaseInfoStruct {
        string card_id;
        string name;
        int256 age;
        string gender;
        int256 loan_amount;
        int256 annual_income;
    }

    event CreateResult(int256 count);
    event InsertResult(int256 count);
    event UpdateResult(int256 count);
    event RemoveResult(int256 count);

    TableFactory tableFactory;
    string constant TABLE_NAME = "farmer_baseinfo";
    constructor() public {
        tableFactory = TableFactory(0x1001); //The fixed address is 0x1001 for TableFactory
        // the parameters of createTable are tableName,keyField,"vlaueFiled1,vlaueFiled2,vlaueFiled3,..."
        tableFactory.createTable(TABLE_NAME, "card_id", "name,age,gender,loan_amount,annual_income");//
    }

    //select records
    function select(string memory card_id)
    public
    view
    returns (FarmerBaseInfoStruct[] memory)//"card_id", "name,age,gender,loan_amount,annual_income" //
    {
        Table table = tableFactory.openTable(TABLE_NAME);

        Condition condition = table.newCondition();

        // //这样不会报错“stack too deep”
        // string[] memory a = new string[](1);
        // a[0] = card_id;
        Entries entries = table.select(card_id, condition);
        
        FarmerBaseInfoStruct[] memory FarmerBaseInfoLists = new FarmerBaseInfoStruct[](uint256(entries.size()));

        for (int256 i = 0; i < entries.size(); ++i) {
            Entry entry = entries.get(i);

            FarmerBaseInfoLists[uint256(i)].card_id = card_id;
            FarmerBaseInfoLists[uint256(i)].name = entry.getString("name");
            FarmerBaseInfoLists[uint256(i)].age = entry.getInt("age");
            FarmerBaseInfoLists[uint256(i)].gender = entry.getString("gender");
            FarmerBaseInfoLists[uint256(i)].loan_amount = entry.getInt("loan_amount");
            FarmerBaseInfoLists[uint256(i)].annual_income = entry.getInt("annual_income");
        }

        return FarmerBaseInfoLists;//
    }
    // Insert records
    function insert(
        string memory card_id,
        string memory name,
        int256 age,
        string memory gender,
        int256 loan_amount,
        int256 annual_income
    ) public returns (int256) {
        Table table = tableFactory.openTable(TABLE_NAME);

        Entry entry = table.newEntry();
        entry.set("card_id", card_id);
        entry.set("name", name);
        entry.set("age", age);
        entry.set("gender", gender);
        entry.set("loan_amount", loan_amount);
        entry.set("annual_income", annual_income);

        int256 count = table.insert(card_id, entry);
        emit InsertResult(count);

        return count;
    }
    // Update records
    function update(
        string memory card_id,
        string memory name,
        int256 age,
        string memory gender,
        int256 loan_amount,
        int256 annual_income
    ) public returns (int256) {
        Table table = tableFactory.openTable(TABLE_NAME);

        Entry entry = table.newEntry();
        entry.set("name", name);
        entry.set("age", age);
        entry.set("gender", gender);
        entry.set("loan_amount", loan_amount);
        entry.set("annual_income", annual_income);

        Condition condition = table.newCondition();
        condition.EQ("card_id", card_id);

        int256 count = table.update(card_id, entry, condition);
        emit UpdateResult(count);

        return count;
    }

    // Remove records
    function remove(string memory card_id) public returns (int256) {
        Table table = tableFactory.openTable(TABLE_NAME);

        Condition condition = table.newCondition();
        condition.EQ("card_id", card_id);

        int256 count = table.remove(card_id, condition);
        emit RemoveResult(count);

        return count;
    }
}