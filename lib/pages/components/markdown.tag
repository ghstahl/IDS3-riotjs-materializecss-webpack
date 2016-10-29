import marked from 'marked'
<markdown>
    <div id="_markdown"></div>
    <style scoped></style>
    <script>
        var self = this;
        self.mixin("opts-mixin");
        self.mixin("shared-observable-mixin");
        self.state = {};

        self.on('mount',function(){
            marked.setOptions({
                renderer: new marked.Renderer(),
                gfm: true,
                tables: true,
                breaks: false,
                pedantic: false,
                sanitize: false,
                smartLists: true,
                smartypants: false
            });
            console.log(marked('I am using __markdown__.'));
        })
        self.on('updated',function(){
            self._markdown.innerHTML  = marked(opts.markdown)
        })

    </script>
</markdown>