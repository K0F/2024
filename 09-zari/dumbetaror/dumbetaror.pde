import java.util.ArrayList;
import java.util.HashMap;

HashMap<String, Float> variableValues;

void setup() {
  size(600, 600); // Zvětšíme velikost okna pro více textu
  background(255);
  fill(0); // Nastavíme barvu textu na černou
  textSize(16); // Nastavíme velikost textu

  // Inicializace proměnných a jejich hodnot
  variableValues = new HashMap<String, Float>();
  variableValues.put("a", 1.0);
  variableValues.put("b", 2.0);
  variableValues.put("γ", 3.0); // Unicode znak
  variableValues.put("δ", 4.0); // Unicode znak

  String[] vars = {"a", "b", "γ", "δ"}; // Proměnné
  String[] ops = {"+", "−", "×", "÷"}; // Operátory

  ArrayList<String> expressions = generateExpressions(vars, ops);

  int y = 20; // Starting Y position for printing
  for (String expr : expressions) {
    Float result = evaluateExpression(expr);
    String output = (result != null) ? expr + " = " + result : expr + " = ERROR";
    
    // Debugging: print to console
    println("Expression: " + expr + " | Result: " + output);
    
    // Drawing text to the window
    text(output, 10, y);
    y += 20; // Move down for the next line
  }
}

ArrayList<String> generateExpressions(String[] vars, String[] ops) {
  ArrayList<String> expressions = new ArrayList<String>();
  // Generování všech kombinací proměnných a operátorů
  for (String op1 : ops) {
    for (String op2 : ops) {
      for (String op3 : ops) {
        expressions.add(vars[0] + " " + op1 + " " + vars[1] + " " + op2 + " " + vars[2] + " " + op3 + " " + vars[3]);
      }
    }
  }
  return expressions;
}

Float evaluateExpression(String expr) {
  String[] tokens = expr.split(" ");
  if (tokens.length != 7) {
    println("Invalid expression format: " + expr);
    return null; // Výraz není platný
  }

  Float result = variableValues.get(tokens[0]);
  if (result == null) {
    println("Variable not found: " + tokens[0]);
    return null;
  }

  for (int i = 1; i < tokens.length; i += 2) {
    if (i + 1 >= tokens.length) {
      println("Operator without following number in expression: " + expr);
      return null; // Chybí číslo po operátoru
    }
    String op = tokens[i];
    Float num = variableValues.get(tokens[i + 1]);
    if (num == null) {
      println("Variable not found: " + tokens[i + 1]);
      return null; // Neplatná proměnná
    }

    switch (op) {
      case "+":
        result += num;
        break;
      case "−": // Unicode minus
        result -= num;
        break;
      case "×":
        result *= num;
        break;
      case "÷":
        if (num != 0) {
          result /= num;
        } else {
          println("Division by zero in expression: " + expr);
          return null; // Vrátí null pro neplatný výpočet
        }
        break;
      default:
        println("Unknown operator: " + op);
        return null; // Vrátí null pro neplatný operátor
    }
  }

  return result;
}
