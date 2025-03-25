export default function SearchBox() {
    return (
        <div className="flex items-center justify-center h-screen">
            <div className="relative w-full max-w-md">
                <input
                    type="text"
                    className="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500"
                    placeholder="Search..."
                />
                <button className="absolute right-2 top-1/2 transform -translate-y-1/2 bg-blue-500 text-white px-4 py-2 rounded-lg">
                    Search
                </button>
            </div>
        </div>
    );
}
