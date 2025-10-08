using System;
using System.Diagnostics;
using System.IO;
using System.Net.Http;

class Program
{
    static async Task Main()
    {
        // Define variables
        string updateFileUrl = "http://192.168.2.245:2040/NewLook/Wdmgr/Updates/nlupdate.txt";
        string localUpdateFile = Path.Combine(Path.GetTempPath(), "nlupdate.txt");
        string smartClientPath = @"C:\newlook 8.0 windows\smartclient.exe";
        string options = "-iwdmgr\\wdmgrwn.ini -cWoodManager";

        // Download the update file using HttpClient
        try
        {
            using (HttpClient httpClient = new HttpClient())
            {
                var response = await httpClient.GetAsync(updateFileUrl);
                response.EnsureSuccessStatusCode();
                var content = await response.Content.ReadAsByteArrayAsync();
                await File.WriteAllBytesAsync(localUpdateFile, content);
                Console.WriteLine("Update file downloaded successfully.");
            }
        }
        catch (Exception ex)
        {
            Console.WriteLine($"Failed to download update file: {ex.Message}");
        }

        // Launch SmartClient
        try
        {
            Process.Start(new ProcessStartInfo
            {
                FileName = smartClientPath,
                Arguments = options,
                WindowStyle = ProcessWindowStyle.Hidden
            });
            Console.WriteLine("SmartClient launched.");
        }
        catch (Exception ex)
        {
            Console.WriteLine($"Failed to launch SmartClient: {ex.Message}");
        }

        // Optional: Auto-close PowerShell window after 1 second
        System.Threading.Thread.Sleep(1000);
    }
}
