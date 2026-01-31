class baseClass:                                                            # Базовый класс
    
    def __init__(self, name):
        self.name = name
        print(f"--> [baseClass] Создан класс с именем {self.name}")

    def test1(self):                                                        # Метод, который будет унаследован без изменений
        print(f"Тестовый метод №1 класса {self.name}")

    def test2(self):                                                        # Метод, который будет переопределен
        print(f"Тестовый метод №2 класса {self.name}")

    def description(self):                                                  # Метод, который мы расширим в дочернем классе
        return f"Название базового класса - {self.name}."


class inheritorClass(baseClass):                                            # Производный класс
    
    def __init__(self, name, test3):
        super().__init__(name)
        self.test3 = test3
        print(f"Тест метода производного класса {self.name}: {self.test3}")

    def test2(self):
        print(f"Переопределенный метод класса {self.name}")

    def description(self):
        base_desc = super().description()
        return f"{base_desc}? Вовсе нет, это название ипроизводного класса."
    
    def test4(self):
        print(f"Уникальный метод класса {self.name}")

if __name__ == "__main__":
    print("=== 1. Работа с базовым классом ===")
    generic_class = baseClass("Базовый класс")
    generic_class.test1()
    generic_class.test2()
    print(generic_class.description())

    print("\n=== 2. Работа с дочерним классом ===")
    inheritor = inheritorClass("Производный класс 1", "Тест3")

    print("\n--- Наследование (метод test1) ---")                           # Вызов унаследованного метода (взят от baseClass)
    inheritor.test1()

    print("\n--- Переопределение (метод test2) ---")                        # Вызов переопределенного метода (свой у inheritorClass)
    inheritor.test2()

    print("\n--- Расширение через super() (метод description) ---")         # Вызов расширенного метода (super + свой код)
    print(inheritor.description())

    print("\n--- Уникальный метод дочернего класса ---")                    # Вызов уникального метода подкласса
    inheritor.test4()