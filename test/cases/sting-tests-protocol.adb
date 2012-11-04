with AUnit.Test_Cases,
     AUnit.Assertions;

package body Sting.Tests.Protocol is
    use AUnit.Test_Cases,
        AUnit.Assertions;

    procedure Test_Test (T : in out Test_Case'Class) is
    begin

        Assert (Condition => (1 = 1),
                Message => "Universe is broken");

    end Test_Test;


    --
    --  AUnit set up code

    procedure Register_Tests (T : in out Test) is
        use AUnit.Test_Cases.Registration;
    begin

        Register_Routine (T, Test_Test'Access, "Validate world");

    end Register_Tests;

    function Name (T : Test) return AUnit.Message_String is
        pragma Unreferenced (T);
    begin
        return AUnit.Format ("Sting Protocol Tests");
    end Name;

end Sting.Tests.Protocol;
