# Tracking Repetitions in Obsidian

You use **Repetition State Properties** in the YAML frontmatter to track where you are in the memorization schedule and surface notes directly inside your tracker base file and Dataview dashboards.

## The Repetition Property
Whenever you create or study a note, ensure the standalone frontmatter property `Repetition: rep/X` is present (never place repetition status inside the `tags:` array, as tracker dashboards rely on the independent property field):

- `Repetition: rep/1` : **Needs 1st Repetition** (In-Class / Active Capture state)
- `Repetition: rep/2` : **Needs 2nd Repetition** (Out-of-Class / Re-organizing and Synthesis state)
- `Repetition: rep/3` : **Needs 3rd Repetition** (Next day / 1-day check)
- `Repetition: rep/4` : **Needs 4th Repetition** (2-3 weeks review)
- `Repetition: rep/5` : **Needs 5th Repetition** (2-3 months review)
- `Repetition: rep/mastered` : Schedule is complete!

## How to use them
1. When you start learning a new topic using `Master Concept Template`, `Repetition: rep/1` is automatically present in the frontmatter.
2. Complete your fast, symbolic notes (1st Rep).
3. Update the property to `Repetition: rep/2`. 
4. Later that day (within 20-30 mins if possible), do your active recall and synthesize the notes into clear headers. 
5. Update the property to `Repetition: rep/3`.
6. Your tracker base file will now automatically group and filter your study topics by their current repetition stage!
