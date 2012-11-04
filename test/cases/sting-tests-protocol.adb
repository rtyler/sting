with AUnit.Test_Cases,
     AUnit.Assertions;

package body Sting.Tests.Protocol is
    use AUnit.Test_Cases,
        AUnit.Assertions;

    procedure Test_Unknown (T : in out Test_Case'Class) is
        Cmd : Sting.Command;
    begin
        Cmd := Sting.Parse ("lolwut?");
        Assert ((Cmd.Kind = Sting.Unknown), "Command is somehow known?");
    end Test_Unknown;

    procedure Test_Ping (T : in out Test_Case'Class) is
        Cmd : Sting.Command;
        Buf : constant String := "ping";
    begin
        Cmd := Sting.Parse (Buf);
        Assert ((Cmd.Kind = Sting.Ping), "Command not a ping!");
    end Test_Ping;


    procedure Test_Read (T : in out Test_Case'Class) is
        Cmd : Sting.Command;
        Buf : constant String := "read /ada";

        use Ada.Containers;
    begin
        Cmd := Sting.Parse (Buf);
        Assert ((Cmd.Kind = Sting.Read), "Command not a read!");
        Assert ((Cmd.Keys.Length > 0), "No keys found in the Command");
        Assert ((Cmd.Keys.First_Element = "ada"), "The correct key is not present in the parsed command");
    end Test_Read;


    --
    --  AUnit set up code

    procedure Register_Tests (T : in out Test) is
        use AUnit.Test_Cases.Registration;
    begin

        Register_Routine (T, Test_Unknown'Access, "Parse an unknown command");
        Register_Routine (T, Test_Ping'Access, "Parse a ping command");
        Register_Routine (T, Test_Read'Access, "Parse a read command");

    end Register_Tests;

    function Name (T : Test) return AUnit.Message_String is
        pragma Unreferenced (T);
    begin
        return AUnit.Format ("Sting Protocol Tests");
    end Name;

end Sting.Tests.Protocol;
