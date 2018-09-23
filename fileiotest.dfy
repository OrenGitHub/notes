include "fileio.dfy"

method ArrayFromSeq<A>(s: seq<A>) returns (a: array<A>)
  ensures a[..] == s
{
  a := new A[|s|] ( i requires 0 <= i < |s| => s[i] );
}

method {:main} Main(ghost env: HostEnvironment)
  requires env.ok.ok()
  modifies env.ok
{
    var fname := ArrayFromSeq("foo.txt");
    var f: FileStream;
    var ok: bool;
    ok, f := FileStream.Open(fname, env);
    if !ok { print "open failed\n"; return; }
    var data: array<byte> := ArrayFromSeq([104, 101, 108, 108, 111, 32, 119, 111, 114, 108, 100, 33, 10]);
    ok := f.Write(0, data, 0, data.Length as int32);

    print "done!\n";
}

