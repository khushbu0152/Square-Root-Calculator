import unittest
from square_root_calculator import calculate_square_root  # Replace with your actual module name

class TestSquareRootFunction(unittest.TestCase):
    def test_positive_number(self):
        self.assertEqual(calculate_square_root(4), 2)
        self.assertEqual(calculate_square_root(9), 3)
    
    def test_zero(self):
        self.assertEqual(calculate_square_root(0), 0)
    
    def test_negative_number(self):
        with self.assertRaises(ValueError):
            calculate_square_root(-4)

if __name__ == "__main__":
    unittest.main()
