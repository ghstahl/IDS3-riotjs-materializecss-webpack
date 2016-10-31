<simple-select>
    <div id={pickerId}>
        <i if={opts.materialIcon} class="material-icons prefix">{opts.materialIcon}</i>
        <select id={selectId}>
            <option  value="-1" disabled selected>{opts.prompt}</option>
            <option  each={opts.items} value={name}>
                {name}
            </option>
        </select>
        <label>{opts.label}</label>
    </div>

    <style></style>
    <script>
        var self = this;
        self.mixin("opts-mixin");
        self.mixin("shared-observable-mixin");

        self.pickerId = opts.name + '-picker'
        self.selectId = opts.name + '-selection'

        self.tick = () =>{
            console.log('tick:simple-select')
            var sElm = $(self[self.selectId]);
            var pElm = $(self[self.pickerId]);
            console.log('simple-select','sElm',sElm,'pElm',pElm)
            //$('select').material_select();
            sElm.material_select();
            pElm.on('change', 'select',self.onSelectChanged);
            clearInterval(self.timer)
            self.update();
        }

        self.onSelectChanged = (e) =>{
            console.log('onSelectChanged',e,e.target.value)
            opts.state.selected = e.target.value;
            self.triggerEvent(opts.name+'-changed',[opts.state]);
        }

        self.on('mount', function() {
            self.timer = setInterval(self.tick, 100)
        })
        self.on('unmount', function() {
            clearInterval(self.timer)
        })
        self.onStateInit = (state) =>{
            opts.state = state
            self.update()
        }
        // place mixins here that require stuff to already exist.
        self.mixin("state-init-mixin");

    </script>
</simple-select>
