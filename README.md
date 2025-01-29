Thank you for reviewing this project.

### Summary: Include screen shots or a video of your app highlighting its features

<kbd>![Simulator Screenshot - iPhone 16 Pro - 2025-01-28 at 20 34 47](https://github.com/user-attachments/assets/4ef1f07f-7188-4a9a-9256-121482d74261)

<kbd>![Simulator Screenshot - iPhone 16 Pro - 2025-01-28 at 20 34 54](https://github.com/user-attachments/assets/f9b259eb-b98e-418b-bf9d-f4b22bebe1e2)

### Focus Areas: What specific areas of the project did you prioritize? Why did you choose to focus on these areas?

Mostly I worked on the image cache over the UI, networking and etc. I chose to prioritize that because it feels like that's where we'd concentrate if this were a real project that required custom caching.

### Time Spent: Approximately how long did you spend working on this project? How did you allocate your time?

Around 8 hours total? I started with downloading the images to memory and showing them in a list, and building out a very simple `FakeCall` for testing. By that point I had a basic app in-place that I could build off of. That took a little over an hour. 

After that I spent a fair amount of time building the image caching. Over the last couple of hours I refined the UI, debugged and wrote most of the tests.

### Trade-offs and Decisions: Did you make any significant trade-offs in your approach?

I decided not to go whole-hog building a fancy UI. I'm not a designer, and wanted to avoid introducing interface bugs and accessiblity issues. Instead I just display the most minimal data to get the point across.

### Weakest Part of the Project: What do you think is the weakest part of your project?

I don't have a great system to handle image download failures. `RecipeImageView` remains in a loading state and tries to reload every time its `task` modifier fires. Eventually the image download is no longer in-flight and we try again until it succeeds. With additional time I'd like to build a more robust system.

### Additional Information: Is there anything else we should know? Feel free to share any insights or constraints you encountered.

I feel like building out he image caching might have been easier if I could use Combine, but it was unclear to me if I should do that given project instructions, so I decided to skip it.
