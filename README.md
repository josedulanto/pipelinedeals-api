PipelineDeals' central goal is to help sales teams manage their deal flow. The Deal is the main domain object we care about.

Each deal has:
• A deal stage: where is it in the pipeline?
• A value: how much is the deal worth?

Your challenge is the following: build an app that does one thing - displays a single page, containing a column chart. The x-axis is the deal stage, and the y-axis is the total $ value of deals in that stage.

Details:
• You'll need an api_key to retrieve all deals available to you - it is G5mZccexXgchNkAYOBlQ.
• Every deal has a deal stage, which is included in the deals.json API response
• A deal stage has a 'percent' field, representing where in the pipeline it sits: 100 = finished. Make sure the deal stage columns in your column chart are ordered by deal stage percentage.
• Ruby for the backend, react front-end
• Add tests for any backend code
• Branch right after creating the new rails app. When complete, create a pull request to your branch and share with us.

Links:
Take a look at our API docs: https://www.pipelinedeals.com/api/docs

### Run server
```
bin/rails s -b 0.0.0.0 -p 3000
```
