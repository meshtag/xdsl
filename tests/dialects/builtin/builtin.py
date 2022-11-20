from xdsl.dialects.builtin import *
from xdsl.printer import *


def test_DenseIntOrFPElemetsAttr():
    # Testing for "_from_list" constructors ensures everything else 
    # ("vector/tensor_from_list") works properly.

    checkTypef32 = AnyTensorType.from_type_and_list(f32, [2])
    checkAttrf32 = DenseIntOrFPElementsAttr.from_list(checkTypef32, [4, 5])

    checkTypei32 = AnyTensorType.from_type_and_list(i32, [2])
    checkAttri32 = DenseIntOrFPElementsAttr.from_list(checkTypei32, [4.0, 5.0])

    # ToDo : Add a test for testing "from_index_list" method.

    # Ensure type conversion happened during attribute construction.
    checkf32 = checkAttrf32.data.data[
        0].value.data == 4.0 and checkAttrf32.data.data[1].value.data == 5.0
    checki32 = checkAttri32.data.data[
        0].value.data == 4 and checkAttri32.data.data[1].value.data == 5

    assert (checkf32)
    assert (checki32)


if __name__ == '__main__':
    test_DenseIntOrFPElemetsAttr()
