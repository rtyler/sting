private with Sting.Tests.Protocol;
private with Sting.Tests.Store;

package body Sting.Tests is
    use AUnit.Test_Suites;

    function Suite return Access_Test_Suite is
        Result : constant Access_Test_Suite := new Test_Suite;
    begin
        Result.Add_Test (new Sting.Tests.Protocol.Test);
        Result.Add_Test (new Sting.Tests.Store.Test);
        return Result;
    end Suite;

end Sting.Tests;
