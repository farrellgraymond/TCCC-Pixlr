#!/bin/bash

CARD4_PNG='../4. Rapid Casualty Assessment ENG - UKR/TCCC ASM Skill Card 4 UKR - Rapid Casualty Assessment.png'
CARD5_PNG='../5. Tourniquet Application ENG - UKR/TCCC ASM Skill Card 5 UKR - Tourniquet Application.png'
CARD6_PNG='../6. Pressure Bandage ENG - UKR/TCCC ASM Skill Card 6 UKR - Pressure Bandage.png'
CARD7_PNG='../7. Wound Packing ENG - UKR/TCCC ASM Skill Card 7 UKR - Wound Packing.png'
CARD8_PNG='../8. Airway Maneuvers ENG - UKR/TCCC ASM Skill Card 8 UKR - Airway Maneuvers.png'
CARD9_PNG='./9 UKR Cards 4-8 Trifold Cover Page PNG.png'

TRIFOLD_P1_PNG='9 Pt1 UKR Cards 4-8 Trifold PNG.png'
TRIFOLD_P2_PNG='9 Pt2 UKR Cards 4-8 Trifold PNG.png'
TRIFOLD_FULL_PDF='9 Full UKR Cards 4-8 Trifold PDF.pdf'

echo "Regenerating Trifold Card 1..."
convert -size 16300x7600 xc:transparent -page +500+500 "${CARD6_PNG}" -page +5600+500 "${CARD8_PNG}" -page +10700+500 "${CARD9_PNG}" -layers flatten "${TRIFOLD_P1_PNG}"

echo "Regenerating Trifold Card 2..."
convert -size 16300x7600 xc:transparent -page +500+500 "${CARD4_PNG}" -page +5600+500 "${CARD5_PNG}" -page +10700+500 "${CARD7_PNG}" -layers flatten "${TRIFOLD_P2_PNG}"

echo "Regenerating Trifold PDF..."
convert "${TRIFOLD_P1_PNG}" "${TRIFOLD_P2_PNG}" "${TRIFOLD_FULL_PDF}"

echo "Regeneration complete!"
