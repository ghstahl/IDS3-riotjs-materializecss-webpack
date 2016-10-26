
<consolidated-form-wrapper>
    <form>
        <div class="card">
            <div class="card-content">
                <span class="card-title">{opts.cardTitle}</span>
                <yield from="content"/>
            </div>
            <div class="card-action">
                <yield from="action"/>
            </div>
        </div>
    </form>
</consolidated-form-wrapper>
