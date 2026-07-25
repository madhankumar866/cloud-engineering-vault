# Tracking Repetitions in Obsidian

Instead of modifying the vault's global taxonomy or hardcoding tags into your templates, you can use these **Repetition State Tags** manually to track where you are in the memorization schedule.

## The Repetition Tags
Whenever you are studying a note, add one of the following tags to its frontmatter (e.g., `tags: [rep/1]`) to track its state:

- `#rep/1` : **Needs 1st Repetition** (In-Class / Active Capture state)
- `#rep/2` : **Needs 2nd Repetition** (Out-of-Class / Re-organizing and Synthesis state)
- `#rep/3` : **Needs 3rd Repetition** (Next day / 1-day check)
- `#rep/4` : **Needs 4th Repetition** (2-3 weeks review)
- `#rep/5` : **Needs 5th Repetition** (2-3 months review)
- `#rep/mastered` : Schedule is complete!

## How to use them
1. When you start learning a new topic and use your `Master Concept Template`, manually type `rep/1` into the frontmatter.
2. Complete your fast, symbolic notes (1st Rep).
3. Change the tag to `rep/2`. 
4. Later that day (within 20-30 mins if possible), do your active recall and synthesize the notes into clear headers. 
5. Change the tag to `rep/3`.
6. You can now use Obsidian's search feature (`tag:#rep/3`) to instantly find all notes that are waiting for their daily review!
