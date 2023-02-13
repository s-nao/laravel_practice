<x-app-layout>
    <div class="max-w-7xl mx-auto sm:px-6 lg:px-8">
        @foreach ($tweets as $tweet)
        <div class="mt-1 bg-white dark:bg-gray-800 overflow-hidden shadow-sm sm:rounded-lg">
            <div class="p-6 text-gray-900 dark:text-gray-100">
                {{ $tweet->id }} : {{ $tweet->message }}
            </div>
        </div>
        @endforeach
    </div>
</x-app-layout>
