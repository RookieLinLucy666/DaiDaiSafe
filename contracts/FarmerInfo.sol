// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

contract FarmerInfo {

    uint256 public farmerIndex;

    constructor() {
        farmerIndex = 0;
    }
    struct Farmer{
        uint256 farmerIndex;  //农户编号
        string idCard;        // 农户身份证
    }

    // 农户基本信息
    struct BasicInfo {
        string idCard;        // 农户身份证
        string name;          // 姓名
        string gender;        // 性别
        uint256 age;             // 年龄
        string maritalStatus; // 婚姻状况
        string email;         // 邮箱
        string phone;         // 手机号
        string homeAddress;   // 家庭地址
    }

    // 贷款信息
    struct LoanInfo {
        string idCard;         // 农户身份证
        uint256 loanAmount;       // 贷款金额
        uint256 loanTerm;         // 贷款期限
        string loanPurpose;    // 贷款目的
        string repaymentMethod; // 还款方式
    }

    // 农户财务与生产信息
    struct FinancialInfo {
        string idCard;             // 农户身份证
        uint256 annualIncome;         // 年收入
        string mainIncomeSource;   // 主要收入来源
        uint256 debtAmount;           // 债务金额
        uint256 assetAmount;          // 资产金额
        string cropOrLivestock;    // 农作物或畜牧品种
        uint256 productionCycle;      // 生产周期
        uint256 expectedEarnings;     // 预计收益
        bool hasAgriculturalInsurance; // 是否有农业保险
    }

    // 三个映射，从idCard到BasicInfo、LoanInfo、FinancialInfo
    mapping(string => BasicInfo) public BasicInfoMapping;
    mapping(string => LoanInfo) public LoanInfoMapping;
    mapping(string => FinancialInfo) public FinancialInfoMapping;

    //从index到农户idCard的映射
    mapping(uint256 => string) public farmers;


//=================================farmers的增删查改===============================
    // 添加农户的函数
    function addFarmer(string memory _idCard) public {
        // 检查是否已存在具有相同 idCard 的农户
        if (selectFarmer(_idCard) >= 0) {
            revert("ID card already exists"); // 如果已存在相同的 idCard，触发回滚并显示错误消息
        }

        farmerIndex += 1;
        farmers[farmerIndex] = _idCard;
    }


    // 获取所有农户ID数组
    function getAllFarmerId() public view returns (string[] memory) {
        string[] memory allFarmerIds = new string[](farmerIndex);
        for (uint256 i = 1; i <= farmerIndex; i++) {
            allFarmerIds[i - 1] = farmers[i];
        }
        return allFarmerIds;
    }

    // 根据农户身份证ID搜索农户的函数
    function selectFarmer(string memory idCard) public view returns (int256) {
        for (uint256 i = 1; i <= farmerIndex; i++) {
            if (keccak256(bytes(farmers[i])) == keccak256(bytes(idCard))) {
                return int256(i); // 找到匹配的农户，返回其索引
            }
        }
        return -1; // 未找到匹配的农户，返回-1
    }


    // 删除农户的函数
    function deleteFarmer(string memory idCard) public returns (bool) {
        // 查找匹配的农户索引
        uint256 indexToDelete = 0;
        for (uint256 i = 1; i <= farmerIndex; i++) {
            if (keccak256(bytes(farmers[i])) == keccak256(bytes(idCard))) {
                indexToDelete = i;
                break;
            }
        }

        // 如果未找到匹配的农户，返回false
        if (indexToDelete == 0) {
            return false;
        }

        // 删除匹配的农户，将后续元素往前移动
        for (uint256 i = indexToDelete; i < farmerIndex; i++) {
            farmers[i] = farmers[i + 1];
        }

        // 将最后一个元素设为空
        farmers[farmerIndex] = "";

        // 减少农户索引计数
        farmerIndex--;

        // 返回true表示删除成功
        return true;
    }

    // 更新农户的函数
    function updateFarmer(string memory oldIdCard, string memory newIdCard) public returns (bool) {
        int256 index = selectFarmer(oldIdCard);

        // 检查是否找到匹配的 oldIdCard
        if (index != -1) {
            farmers[uint256(index)] = newIdCard;
            return true; // 找到并更新了 oldIdCard，返回true
        } else {
            return false; // 未找到匹配的 oldIdCard，返回false
        }
    }

//=================================basicInfo的增删查改===============================

    // 添加农户的基本信息
    function addBasicInfo(
        string memory idCard,
        string memory name,
        string memory gender,
        uint256 age,
        string memory maritalStatus,
        string memory email,
        string memory phone,
        string memory homeAddress
    ) public {
        // 创建 BasicInfo 结构体
        BasicInfo memory newBasicInfo = BasicInfo(
            idCard,
            name,
            gender,
            age,
            maritalStatus,
            email,
            phone,
            homeAddress
        );
 
        // 将 BasicInfo 结构体添加到映射中
        BasicInfoMapping[idCard] = newBasicInfo;
    }

    // 根据农户身份证ID获取基本信息的函数
    function selectBasicInfo(string memory idCard) public view returns (
        string memory name,
        string memory gender,
        uint256 age,
        string memory maritalStatus,
        string memory email,
        string memory phone,
        string memory homeAddress
    ) {
        // 使用 selectFarmer 函数检查该 idCard 是否存在
        int256 index = selectFarmer(idCard);

        // 如果未找到匹配的 idCard，则返回空的字段
        if (index == -1) {
            return ("", "", 0, "", "", "", "");
        }

        // 如果找到匹配的 idCard，返回对应的基本信息字段
        BasicInfo memory info = BasicInfoMapping[idCard];
        return (
            info.name,
            info.gender,
            info.age,
            info.maritalStatus,
            info.email,
            info.phone,
            info.homeAddress
        );
    }

    // 删除农户的基本信息
    function deleteBasicInfo(string memory idCard) public returns (bool) {
        // 使用 selectFarmer 函数检查该 idCard 是否存在
        int256 index = selectFarmer(idCard);

        // 如果未找到匹配的 idCard，则返回false
        if (index == -1) {
            return false;
        }

        // 检查该农户的基本信息是否已经添加过
        if (bytes(BasicInfoMapping[idCard].idCard).length == 0) {
            return false;
        }

        // 删除 BasicInfo 结构体
        delete BasicInfoMapping[idCard];

        return true; // 返回true表示删除成功
    }

    // 更新农户的基本信息
    function updateBasicInfo(
        string memory idCard,
        string memory name,
        string memory gender,
        uint256 age,
        string memory maritalStatus,
        string memory email,
        string memory phone,
        string memory homeAddress
    ) public returns (bool) {
        // 使用 selectFarmer 函数检查该 idCard 是否存在
        int256 index = selectFarmer(idCard);

        // 如果未找到匹配的 idCard，则返回false
        if (index == -1) {
            return false;
        }

        // 检查该农户的基本信息是否已经添加过
        if (bytes(BasicInfoMapping[idCard].idCard).length == 0) {
            return false;
        }

        // 更新 BasicInfo 结构体的字段
        BasicInfoMapping[idCard].name = name;
        BasicInfoMapping[idCard].gender = gender;
        BasicInfoMapping[idCard].age = age;
        BasicInfoMapping[idCard].maritalStatus = maritalStatus;
        BasicInfoMapping[idCard].email = email;
        BasicInfoMapping[idCard].phone = phone;
        BasicInfoMapping[idCard].homeAddress = homeAddress;

        return true; // 返回true表示更新成功
    }

//=================================loanInfo的增删查改===============================
    // 添加农户的贷款信息
    function addLoanInfo(
        string memory idCard,
        uint256 loanAmount,
        uint256 loanTerm,
        string memory loanPurpose,
        string memory repaymentMethod
    ) public {
        // 使用 selectFarmer 函数检查该 idCard 是否存在
        int256 index = selectFarmer(idCard);

        // 如果未找到匹配的 idCard，则返回
        if (index == -1) {
            revert("ID card not found");
        }

        // 创建 LoanInfo 结构体
        LoanInfo memory newLoanInfo = LoanInfo(
            idCard,
            loanAmount,
            loanTerm,
            loanPurpose,
            repaymentMethod
        );

        // 将 LoanInfo 结构体添加到映射中
        LoanInfoMapping[idCard] = newLoanInfo;
    }

    // 获取农户的贷款信息
    function selectLoanInfo(string memory idCard) public view returns (
        uint256 loanAmount,
        uint256 loanTerm,
        string memory loanPurpose,
        string memory repaymentMethod
    ) {
        // 使用 selectFarmer 函数检查该 idCard 是否存在
        int256 index = selectFarmer(idCard);

        // 如果未找到匹配的 idCard，则返回空的字段
        if (index == -1) {
            return (0, 0, "", "");
        }

        // 如果找到匹配的 idCard，返回对应的贷款信息字段
        LoanInfo memory info = LoanInfoMapping[idCard];
        return (
            info.loanAmount,
            info.loanTerm,
            info.loanPurpose,
            info.repaymentMethod
        );
    }

    // 删除农户的贷款信息
    function deleteLoanInfo(string memory idCard) public returns (bool) {
        // 使用 selectFarmer 函数检查该 idCard 是否存在
        int256 index = selectFarmer(idCard);

        // 如果未找到匹配的 idCard，则返回false
        if (index == -1) {
            return false;
        }

        // 删除 LoanInfo 结构体
        delete LoanInfoMapping[idCard];

        return true; // 返回true表示删除成功
    }

    // 更新农户的贷款信息
    function updateLoanInfo(
        string memory idCard,
        uint256 loanAmount,
        uint256 loanTerm,
        string memory loanPurpose,
        string memory repaymentMethod
    ) public returns (bool) {
        // 使用 selectFarmer 函数检查该 idCard 是否存在
        int256 index = selectFarmer(idCard);

        // 如果未找到匹配的 idCard，则返回false
        if (index == -1) {
            return false;
        }

        // 更新 LoanInfo 结构体的字段
        LoanInfoMapping[idCard] = LoanInfo(
            idCard,
            loanAmount,
            loanTerm,
            loanPurpose,
            repaymentMethod
        );

        return true; // 返回true表示更新成功
    }    

//=================================financialInfo的增删查改===============================
    function addFinancialInfo(
        string memory idCard,
        uint256 annualIncome,
        string memory mainIncomeSource,
        uint256 debtAmount,
        uint256 assetAmount,
        string memory cropOrLivestock,
        uint256 productionCycle,
        uint256 expectedEarnings,
        bool hasAgriculturalInsurance
    ) public {
        // 使用 selectFarmer 函数检查该 idCard 是否存在
        int256 index = selectFarmer(idCard);

        // 如果未找到匹配的 idCard，则返回
        if (index == -1) {
            revert("ID card not found");
        }

        // 创建 FinancialInfo 结构体
        FinancialInfo memory newFinancialInfo = FinancialInfo(
            idCard,
            annualIncome,
            mainIncomeSource,
            debtAmount,
            assetAmount,
            cropOrLivestock,
            productionCycle,
            expectedEarnings,
            hasAgriculturalInsurance
        );

        // 将 FinancialInfo 结构体添加到映射中
        FinancialInfoMapping[idCard] = newFinancialInfo;
    }

    // 获取农户的财务与生产信息
    function selectFinancialInfo(string memory idCard) public view returns (
        uint256 annualIncome,
        string memory mainIncomeSource,
        uint256 debtAmount,
        uint256 assetAmount,
        string memory cropOrLivestock,
        uint256 productionCycle,
        uint256 expectedEarnings,
        bool hasAgriculturalInsurance
    ) {
        // 使用 selectFarmer 函数检查该 idCard 是否存在
        int256 index = selectFarmer(idCard);

        // 如果未找到匹配的 idCard，则返回空的字段
        if (index == -1) {
            return (0, "", 0, 0, "", 0, 0, false);
        }

        // 如果找到匹配的 idCard，返回对应的财务与生产信息字段
        FinancialInfo memory info = FinancialInfoMapping[idCard];
        return (
            info.annualIncome,
            info.mainIncomeSource,
            info.debtAmount,
            info.assetAmount,
            info.cropOrLivestock,
            info.productionCycle,
            info.expectedEarnings,
            info.hasAgriculturalInsurance
        );
    }

    // 删除农户的财务与生产信息
    function deleteFinancialInfo(string memory idCard) public returns (bool) {
        // 使用 selectFarmer 函数检查该 idCard 是否存在
        int256 index = selectFarmer(idCard);

        // 如果未找到匹配的 idCard，则返回false
        if (index == -1) {
            return false;
        }

        // 删除 FinancialInfo 结构体
        delete FinancialInfoMapping[idCard];

        return true; // 返回true表示删除成功
    }

    // 更新农户的财务与生产信息
    function updateFinancialInfo(
        string memory idCard,
        uint256 annualIncome,
        string memory mainIncomeSource,
        uint256 debtAmount,
        uint256 assetAmount,
        string memory cropOrLivestock,
        uint256 productionCycle,
        uint256 expectedEarnings,
        bool hasAgriculturalInsurance
    ) public returns (bool) {
        // 使用 selectFarmer 函数检查该 idCard 是否存在
        int256 index = selectFarmer(idCard);

        // 如果未找到匹配的 idCard，则返回false
        if (index == -1) {
            return false;
        }

        // 更新 FinancialInfo 结构体的字段
        FinancialInfoMapping[idCard] = FinancialInfo(
            idCard,
            annualIncome,
            mainIncomeSource,
            debtAmount,
            assetAmount,
            cropOrLivestock,
            productionCycle,
            expectedEarnings,
            hasAgriculturalInsurance
        );

        return true; // 返回true表示更新成功
    }

}





