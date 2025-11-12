/**
 * Minigrep in Java
 *
 * @author Brad White
 * @date 2025-10-21
 */

import java.io.FileInputStream;
import java.io.IOException;

class Minigrep {
  public static void main(String[] args) {
    if (args.length < 2) {
      System.out.println("Usage: minigrep <pattern> <file>");
      System.exit(1);
    }

    String pattern = args[0];
    String file = args[1];

    try {
      FileInputStream fis = new FileInputStream(file);
      byte[] buffer = new byte[1024];
      int read;
      while ((read = fis.read(buffer)) != -1) {
        String content = new String(buffer, 0, read);
        String[] lines = content.split("\n");
        boolean found = false;
        int lineNumber = 0;
        for (String line : lines) {
          if (line.contains(pattern)) {
            System.out.println(lineNumber + ": " + line);
            found = true;
          }
          lineNumber++;
        }
        if (!found) {
          System.out.println("No matches found");
        }
      }
    } catch (IOException e) {
      System.out.println("Error reading file: " + e.getMessage());
    }
  }
}
