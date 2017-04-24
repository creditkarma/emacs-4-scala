import org.ensime.EnsimeKeys._
import org.ensime.EnsimeCoursierKeys._

// this loads the current development version of ensime, which is the
// one you want. really, it is so don't worry about it.
ensimeServerVersion in ThisBuild := "2.0.0-SNAPSHOT"

// if this isn't set then ensime will create 2.11 and 2.12 specific
// directories for you in your tree :(
ensimeIgnoreMissingDirectories in ThisBuild := true
