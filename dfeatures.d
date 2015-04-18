import std.stdio,std.typecons;

import std.array;
import std.algorithm;

class Prop{

  public string prop1(){
    return "prop1_value";
  }
}

interface Shape{
  string name();
}

class Tangle : Shape{
  string name(){
    return "tangle";
  }
}

struct S{
  int a=10;
}

string fun1(Tangle t){
  return t.name;
}

void main(string[] args){
  Prop d = new Prop();
  d.prop1;
  writeln("feature 1: member function without parameters as property(conflicts with same name field)");
  writeln("feature 2: not support struct inheritance");
  auto t = new Tangle();
  t=null;
  auto s = Nullable!Shape();
  //  s= new Tangle();
  writeln(s.isNull);
  s=null;
  writeln(s.isNull);
  s.nullify();
  //  writeln(s.get);

   writeln("feature 3: not support string/int array" ~ r"auto a = ['aa',3,4.8,false];");

   auto a= [1,2,3];
   writeln(a.sizeof);
   int[1] a2 = new int[1];
   writeln(a2.sizeof);
   int[] a3 = [];
   writeln(a3.sizeof);

   writeln("feature 4: static/dynamic array different sizeof and init");
   writeln(a3.ptr);
   a3~= new int[10];
   writeln(a3.ptr);
   int [] b = a3[0..1];
   writeln(b[0]);
   a3 ~= [1,2,3,4,5,6,7,8,9];
   a3[0]=3;
   writeln(a3.ptr);
   writeln(b[0]);
   writeln(a.length,a.ptr);
   a~=2;
   writeln(a.length,a.ptr);
   writeln("feature 5: dynamic&static array ptr is changed when appended");

   Tangle tt = new Tangle();
   writeln(tt.fun1);
   writeln("feature 6: Uniform Function Call Syntax");
   //   int [] b = a[1..$];
   //writeln(a.ptr,"->",b.ptr);
}


    void main1() {
      stdin.byLine(KeepTerminator.yes).map!(a => a.idup).array.sort.copy(stdout.lockingTextWriter());
    }
