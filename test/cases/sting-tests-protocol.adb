with AUnit.Test_Cases,
     AUnit.Assertions;

package body Sting.Tests.Protocol is
    use AUnit.Test_Cases,
        AUnit.Assertions;

    procedure Test_Ping (T : in out Test_Case'Class) is
        Cmd : Sting.Command;
        Buf : constant String := "ping";
    begin
        Cmd := Sting.Parse (Buf);
        Assert ((Cmd.Kind = Sting.Ping), "Command not a ping!");
    end Test_Ping;


    --
    --  AUnit set up code

    procedure Register_Tests (T : in out Test) is
        use AUnit.Test_Cases.Registration;
    begin

        Register_Routine (T, Test_Ping'Access, "Parse a ping command");

    end Register_Tests;

    function Name (T : Test) return AUnit.Message_String is
        pragma Unreferenced (T);
    begin
        return AUnit.Format ("Sting Protocol Tests");
    end Name;

end Sting.Tests.Protocol;
