with AUnit.Test_Suites;

package body Sting.Tests is
    use AUnit.Test_Suites;

    function Suite return Access_Test_Suite is
        Result : constant Access_Test_Suite := new Test_Suite;
    begin
        return Result;
    end Suite;

end Sting.Tests;
