from xdsl.dialects.builtin import *
from xdsl.printer import *

checkAttr = DenseIntOrFPElementsAttr.tensor_from_list([4, 5], f32)

checkType = AnyTensorType.from_type_and_list(f32, [2])
checkAttrList = DenseIntOrFPElementsAttr.from_list(checkType, [4, 5])

# checkAttr1 = DenseIntOrFPElementsAttr.tensor_from_list([4.0, 5.0], i32)
print(checkAttr.data.data[0].value.data)
print(checkAttrList.data.data[1].value.data)


# checkAttr2 = DenseIntOrFPElementsAttr.tensor_from_list([4, 5], IndexType)
