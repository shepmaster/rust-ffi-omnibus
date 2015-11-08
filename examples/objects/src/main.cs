using System;
using System.Runtime.InteropServices;

internal class Native
{
    [DllImport("objects")]
    internal static extern ZipCodeDatabaseHandle zip_code_database_new();
    [DllImport("objects")]
    internal static extern void zip_code_database_free(IntPtr db);
    [DllImport("objects")]
    internal static extern void zip_code_database_populate(ZipCodeDatabaseHandle db);
    [DllImport("objects")]
    internal static extern uint zip_code_database_population_of(ZipCodeDatabaseHandle db, string zip);
}

internal class ZipCodeDatabaseHandle : SafeHandle
{
    public ZipCodeDatabaseHandle() : base(IntPtr.Zero, true) {}

    public override bool IsInvalid
    {
        get { return false; }
    }

    protected override bool ReleaseHandle()
    {
        Native.zip_code_database_free(handle);
        return true;
    }
}

public class ZipCodeDatabase : IDisposable
{
    private ZipCodeDatabaseHandle db;

    public ZipCodeDatabase()
    {
        db = Native.zip_code_database_new();
    }

    public void Populate()
    {
        Native.zip_code_database_populate(db);
    }

    public uint PopulationOf(string zip)
    {
        return Native.zip_code_database_population_of(db, zip);
    }

    public void Dispose()
    {
        db.Dispose();
    }

    static public void Main()
    {
          var db = new ZipCodeDatabase();
          db.Populate();

          var pop1 = db.PopulationOf("90210");
          var pop2 = db.PopulationOf("20500");

          Console.WriteLine("{0}", pop1 - pop2);
    }
}
