#!/bin/bash

# 引数の数をチェック
if [ "$#" -lt 1 ] || [ "$#" -gt 2 ]; then
    echo "Usage: $0 <package_name> [output_directory]"
    exit 1
fi

NODE_NAME=$1
PACKAGE_NAME=terrauto_$NODE_NAME
CLASS_NAME=$(echo "$NODE_NAME" | sed -r 's/(^|_)([a-z])/\U\2/g')

if [ -n "$2" ]; then
    PACKAGE_DIR=$(realpath "$2")
else
    PACKAGE_DIR=$(pwd)
fi

# パッケージディレクトリの作成
mkdir -p "$PACKAGE_DIR/$PACKAGE_NAME/src"
mkdir -p "$PACKAGE_DIR/$PACKAGE_NAME/include/$PACKAGE_NAME"

TEMPLATE_DIR=$(dirname "$0")/template

# ファイルをコピーして変数を埋め込む
for TEMPLATE in .CMakeLists.txt .package.xml .node.cpp .component.cpp .component.hpp; do
    TEMPLATE_PATH="$TEMPLATE_DIR/$TEMPLATE"
    OUTPUT_FILE="$PACKAGE_DIR/$PACKAGE_NAME/${TEMPLATE#.}"

    sed -e "s/{{NODE_NAME}}/$NODE_NAME/g" \
        -e "s/{{PACKAGE_NAME}}/$PACKAGE_NAME/g" \
        -e "s/{{CLASS_NAME}}/$CLASS_NAME/g" \
        -e "s/{{NODE_NAME_UPPER}}/$(echo "$NODE_NAME" | tr '[:lower:]' '[:upper:]')/g" \
        -e "s/{{PACKAGE_NAME_UPPER}}/$(echo "$PACKAGE_NAME" | tr '[:lower:]' '[:upper:]')/g" \
        "$TEMPLATE_PATH" >"$OUTPUT_FILE"
done

# ファイルのリネーム
mv "$PACKAGE_DIR/$PACKAGE_NAME/node.cpp" "$PACKAGE_DIR/$PACKAGE_NAME/src/${NODE_NAME}_node.cpp"
mv "$PACKAGE_DIR/$PACKAGE_NAME/component.cpp" "$PACKAGE_DIR/$PACKAGE_NAME/src/${NODE_NAME}_component.cpp"
mv "$PACKAGE_DIR/$PACKAGE_NAME/component.hpp" "$PACKAGE_DIR/$PACKAGE_NAME/include/$PACKAGE_NAME/${NODE_NAME}_component.hpp"

echo "ROS 2 C++ package '$PACKAGE_NAME' has been created in $PACKAGE_DIR/$PACKAGE_NAME"
