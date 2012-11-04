with AUnit.Run;
with AUnit.Reporter.Text;
use AUnit.Reporter.Text;


package body Sting.Tests.Runner is
    procedure Main is
        procedure Runner is new AUnit.Run.Test_Runner (Sting.Tests.Suite);
        Reporter : Text_Reporter;
    begin
        Set_Use_ANSI_Colors (Engine => Reporter, Value => True);
        Runner (Reporter);
    end Main;
end Sting.Tests.Runner;
