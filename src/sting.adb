private with GNAT.String_Split;
use GNAT.String_Split;
with Ada.Text_IO,
     Ada.Characters.Latin_1;
use Ada.Text_IO;

package body Sting is

    procedure Validate_Key (Key : in String) is
    begin
        if (Key'Length > Max_Key_Length) or (Key'Length = 0) then
            raise Invalid_Key_Error;
        end if;
    end Validate_Key;


    procedure Parse_Keys (C : in out Command; Parts : in Slice_Set) is
    begin
        -- Assume we're starting just after the first part, i.e. the command
        -- ("read", "delete", etc)
        for I in 2 .. Slice_Count (Parts) loop
            declare
                Keys : Slice_Set;
            begin
                -- Break the keys into a Slice_Set of "/one/two/three" ->
                -- ["one", "two", "three"]
                Create (Keys, Slice (Parts, I), "/", Mode => Multiple);

                for J in 2 .. Slice_Count (Keys) loop
                    declare
                        Key : String := Slice (Keys, J);
                    begin
                        Validate_Key (Key);
                        C.Keys.Append (Key);
                    end;
                end loop;
            end;
        end loop;
    end Parse_Keys;

    function Parse (Buffer : in String) return Command is
        C : Command;
        Parts : Slice_Set;
    begin
        -- Set the command kind as Unknown until we figure out what it is
        -- exactly
        C.Kind := Sting.Unknown;

        if Buffer = "ping" then
            C.Kind := Sting.Ping;
            return C;
        end if;

        -- For all other commands, we need to parse out the command from the
        -- key
        Create (Parts, Buffer, " ", Mode => Multiple);

        -- Return early if we don't have enough parts to our command
        if Slice_Count (Parts) < 2 then
            return C;
        end if;

        if Slice (Parts, 1) = "read" then
            C.Kind := Sting.Read;
        end if;

        Parse_Keys (C, Parts);

        return C;
    end Parse;

end Sting;
