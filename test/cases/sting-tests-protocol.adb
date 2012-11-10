with AUnit.Assertions;

package body Sting.Tests.Protocol is
    use AUnit.Test_Cases,
        AUnit.Assertions;

    procedure Test_Unknown (T : in out Test_Case'Class) is
        pragma Unreferenced (T);
        Cmd : Sting.Command;
    begin
        Cmd := Sting.Parse ("lolwut?");
        Assert ((Cmd.Kind = Sting.Unknown), "Command is somehow known?");
    end Test_Unknown;


    procedure Test_Ping (T : in out Test_Case'Class) is
        pragma Unreferenced (T);
        Cmd : Sting.Command;
        Buf : constant String := "ping";
    begin
        Cmd := Sting.Parse (Buf);
        Assert ((Cmd.Kind = Sting.Ping), "Command not a ping!");
    end Test_Ping;


    procedure Test_Read (T : in out Test_Case'Class) is
        pragma Unreferenced (T);
        Cmd : Sting.Command;
        Buf : constant String := "read /ada";

        use Ada.Containers;
    begin
        Cmd := Sting.Parse (Buf);
        Assert ((Cmd.Kind = Sting.Read), "Command not a read!");
        Assert ((Cmd.Keys.Length > 0), "No keys found in the Command");
        Assert ((Cmd.Keys.First_Element = "ada"), "The correct key is not present in the parsed command");
    end Test_Read;


    procedure Test_Read_Many_Keys (T : in out Test_Case'Class) is
        pragma Unreferenced (T);
        type SA is access String;
        Cmd : Sting.Command;
        Buf : constant String := "read /ada/is/neat";
        Keys : constant array (Positive range 1 .. 3) of SA := (new String'("ada"),
                                                                new String'("is"),
                                                                new String'("neat"));

        use Ada.Containers;
    begin
        Cmd := Sting.Parse (Buf);
        Assert ((Cmd.Kind = Sting.Read), "Command is not a read!");
        Assert ((Cmd.Keys.Length = 3), "Incorrect number of keys found");

        declare
            Cursor : Key_Chain.Cursor := Cmd.Keys.First;
        begin
            for I in Keys'Range loop
                declare
                    Current : constant String := Key_Chain.Element (Cursor);
                    Expected : constant String := Keys (I).all;
                begin
                    Assert ((Current = Expected),
                                "The key '" & Current & "' was expected to be '" & Expected & "'");
                    Cursor := Key_Chain.Next (Cursor);
                end;
            end loop;
        end;
    end Test_Read_Many_Keys;


    procedure Test_Read_Big_Key (T : in out Test_Case'Class) is
        pragma Unreferenced (T);
        Cmd : Command;
        -- Let's create a key that is a boatload of "f" characters
        Key : constant String (1 .. (Max_Key_Length + 1)) := (others => 'f');
        Buf : constant String := "read /" & Key;
    begin
        Cmd := Parse (Buf);
        Assert (False, "Failed to raise an Invalid_Key_Error");
    exception
        when Invalid_Key_Error =>
            null;
    end Test_Read_Big_Key;


    procedure Test_Read_Empty_Key (T : in out Test_Case'Class) is
        pragma Unreferenced (T);
        Cmd : Command;
        Buf : constant String := "read /";
    begin
        Cmd := Parse (Buf);
        Assert (False, "Failed to raise an Invalid_Key_Error");
    exception
        when Invalid_Key_Error =>
            null;
    end Test_Read_Empty_Key;


    --
    --  AUnit set up code

    procedure Register_Tests (T : in out Test) is
        use AUnit.Test_Cases.Registration;
    begin

        Register_Routine (T, Test_Unknown'Access, "Parse an unknown command");
        Register_Routine (T, Test_Ping'Access, "Parse a ping command");
        Register_Routine (T, Test_Read'Access, "Parse a read command");
        Register_Routine (T, Test_Read_Many_Keys'Access, "Parse a read command with composite keys");
        Register_Routine (T, Test_Read_Big_Key'Access, "Raise an error when reading a key that's too damn big");
        Register_Routine (T, Test_Read_Empty_Key'Access, "Raise an error when reading an empty key");

    end Register_Tests;

    function Name (T : Test) return AUnit.Message_String is
        pragma Unreferenced (T);
    begin
        return AUnit.Format ("Sting Protocol Tests");
    end Name;

end Sting.Tests.Protocol;
