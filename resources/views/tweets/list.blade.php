<x-app-layout>
    <div class="max-w-7xl mx-auto sm:px-6 lg:px-8">
        @foreach ($tweets as $tweet)
        <div class="mt-1 bg-white overflow-hidden">
            <div class="p-6 text-gray-900 ">
                {{ $tweet->id }} : {{ $tweet->message }}
            </div>
        </div>
        @endforeach
    </div>
</x-app-layout>
