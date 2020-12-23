// Fix instant wake on AC power
// Patch: Rename GPRW to YPRW
// Find: 14 40 06 47 50 52 57 02
// Replace: 14 40 06 59 50 52 57 02
// References:
// [1] https://github.com/daliansky/OC-little/tree/master/14-0D6D%E8%A1%A5%E4%B8%81
// [2] https://github.com/RehabMan/OS-X-Clover-Laptop-Config/blob/master/hotpatch/SSDT-UPRW.dsl

DefinitionBlock ("", "SSDT", 2, "hack", "GPRW", 0x00000000)
{
    External (YPRW, MethodObj)    // 2 Arguments

    Scope (\)
    {
        Method (GPRW, 2, NotSerialized)
        {
            If (_OSI ("Darwin") && (0x6D == Arg0))
            {
                Return (Package (0x02)
                {
                    0x6D, 
                    Zero
                })
            }
            
            Return (\YPRW (Arg0, Arg1))
        }
    }
}

