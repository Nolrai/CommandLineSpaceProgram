import Lake
open Lake DSL

package CommandLineSpaceProgram

lean_lib CommandLineSpaceProgram

lean_exe clsp {
  root := `SpaceMain
}
