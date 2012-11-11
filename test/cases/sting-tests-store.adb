with AUnit.Assertions;
with Sting.Store;

package body Sting.Tests.Store is
    use AUnit.Test_Cases,
        AUnit.Assertions;

    procedure Test_Count_Empty (T : in out Test_Case'Class) is
        pragma Unreferenced (T);
        S : Sting.Store.Engine;
    begin
        Assert ((S.Count = 0), "The Count isn't correct!");
    end Test_Count_Empty;


    procedure Test_Insert_Simple_Key_Value (T : in out Test_Case'Class) is
        use Sting.Store;
        pragma Unreferenced (T);
        S : Sting.Store.Engine;
    begin
        S.Insert (new String'("a-key"), new String'("some silly value!"));

        Assert ((S.Count = 1),
                "The Count isn't correct: " & Natural'Image (S.Count));
    end Test_Insert_Simple_Key_Value;


    procedure Register_Tests (T : in out Test) is
        use AUnit.Test_Cases.Registration;
    begin
        Register_Routine (T, Test_Count_Empty'Access, "Check the count on an empty Sting Store");
        Register_Routine (T, Test_Insert_Simple_Key_Value'Access,
                            "Perform a simple insertion into the storage engine");
    end Register_Tests;


    function Name (T : Test) return AUnit.Message_String is
        pragma Unreferenced (T);
    begin
        return AUnit.Format ("Sting Store Tests");
    end Name;

end Sting.Tests.Store;
