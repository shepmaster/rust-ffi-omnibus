import com.sun.jna.Library;
import com.sun.jna.Native;
import com.sun.jna.Platform;

public class App {
  public interface MyLibrary extends Library {
      MyLibrary INSTANCE = (MyLibrary) Native.loadLibrary("integers", MyLibrary.class);
      int addition(int a , int b);
  }

  public static void main(String[] args) {
    System.setProperty("java.library.path", "../target/debug");
    int sum = MyLibrary.INSTANCE.addition(1,2);
    System.out.println(sum);
  }
}
