/*
 * Beangle File Line Counter
 *
 * Copyright (c) 2005-2012, Beangle Software.
 *
 * Beangle is free software: you can redistribute it and/or modify
 * it under the terms of the GNU Lesser General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 * 
 * Beangle is distributed in the hope that it will be useful.
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU Lesser General Public License for more details.
 
 * You should have received a copy of the GNU Lesser General Public License
 * along with Beangle.  If not, see <http://www.gnu.org/licenses/>.*
 */
import std.stdio,std.file,std.datetime;

void main(string[] args){
  if(args.length<3){
    writeln("Usage linecounter path regex [minlenth]");
    return;
  }
  string path=args[1];
  string regex=args[2];
  
  LineCounter lc=new LineCounter(path,regex);
  lc.visit();
}

/**
 * Directory File line counter
 *
 */
class LineCounter{
  uint[string] filelines;
  string[] fileNames=[];
  string path;
  string suffix;
  uint minlength=500;
  uint sum=0;

  this(string path,string suffix){
    this.path=path;
    this.suffix="." ~ suffix;
  }

  void visit(){
    if(!path.isDir) return;
    sum=0;
    StopWatch sw;
    sw.start();
    //auto dFiles=filter!`endsWith(a.name,"*.java")`(dirEntries(path, SpanMode.depth));
    foreach (string name;dirEntries(path, SpanMode.breadth)) {
      if(name[$-suffix.length..$] == suffix){
        auto fileline=counter(name);
        if(fileline>minlength){
          fileNames ~= name;
          filelines[name]=fileline;
        }
        sum += fileline;
      }
    }
    foreach(name;fileNames){
      writeln(name ,"\t",filelines[name]);
    }
    writeln("overall " ,sum," in ",sw.peek().msecs," ms");
  }

  int counter(string filename){
    char [] buf;
    int line=0;
    File file=File(filename);
    while(file.readln(buf)) line++;
    return line;
  }
}