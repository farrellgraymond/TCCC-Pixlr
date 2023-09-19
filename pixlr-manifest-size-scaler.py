import json
import sys

print(sys.argv)

scale_factor=4
input_file=sys.argv[1]

with open(input_file, "r") as manifest_file:
    manifest_dict = json.load(manifest_file)
    print('Scaling all sizes in [{}] by {}x...'.format(input_file, scale_factor))

    for key, value in manifest_dict.items():
        if key == 'width' or key == 'height':
            manifest_dict[key] = value * scale_factor
            print('-- Scale key [{}] {} -> {}'.format(key, value, manifest_dict[key]))
        
        if type(value) is list:
            for curLayer in value:
                print('-- Shape name [{}]'.format(curLayer['name']))

                # These are all dicts with a standard format
                for layerKey, layerValue in curLayer['rect'].items():
                    if layerKey == 'x' or layerKey == 'y' or layerKey == 'w' or layerKey == 'h' or layerKey == 'size':
                        curLayer['rect'][layerKey] = layerValue * scale_factor
                        print('---- Scale key [{}] {} -> {}'.format(layerKey, layerValue, curLayer['rect'][layerKey]))

                # These are all dicts with a standard format
                if 'format' not in curLayer:
                    continue;
                for layerKey, layerValue in curLayer['format'].items():
                    if layerKey == 'size':
                        curLayer['format'][layerKey] = layerValue * scale_factor
                        print('---- Scale key [{}] {} -> {}'.format(layerKey, layerValue, curLayer['format'][layerKey]))


with open('{}-{}x'.format(input_file, scale_factor), "w", encoding='utf8') as double_manifest:
    json.dump(manifest_dict, double_manifest, ensure_ascii=False, indent=2)