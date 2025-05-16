<script>
	import '@evidence-dev/tailwind/fonts.css';
	import '../app.css';
	import { EvidenceDefaultLayout } from '@evidence-dev/core-components';
	export let data;
</script>

<div class="flex flex-col min-h-screen w-full">
    <!-- Main Content Area with Sidebar and Breadcrumbs Hidden -->
    <EvidenceDefaultLayout {data} hideBreadcrumbs = true hideSidebar = true logo = /globalgreen.png neverShowQueries = true>
        <slot slot="content" />
    </EvidenceDefaultLayout>

    <!-- Footer Navigation Bar -->
    <footer class="bg-gray-800 text-white py-4 px-6 shadow-md fixed bottom-0 left-0 w-full rounded-t-sm">
        <ul class="flex justify-center gap-6 text-sm">
            <li><a href="/" class="hover:text-green-400">🏠 Home</a></li>
            <li><a href="/comment_business" class="hover:text-green-400">📈 Business Comments</a></li>
            <li><a href="/income_statement" class="hover:text-green-400">📑 Income Statement</a></li>
            <li><a href="/balance_sheet" class="hover:text-green-400">📊 Balance Sheet</a></li>
            <li><a href="/cashflow" class="hover:text-green-400">💰 Cash Flow</a></li>
            <li><a href="/plant_utilization" class="hover:text-green-400">🏭 Plant Utilization</a></li> 
            <li><a href="/networth" class="hover:text-green-400">💼 Net Worth</a></li> 
            <li><a href="/fixed_cost" class="hover:text-green-400">🧮 Fixed Cost</a></li>
            <li><a href="/fixed_assets" class="hover:text-green-400">🏢 Fixed Assets</a></li>
            <li><a href="/revenue_trend" class="hover:text-green-400">📈 Revenue Trend</a></li>

        </ul>
    </footer>
    
</div>