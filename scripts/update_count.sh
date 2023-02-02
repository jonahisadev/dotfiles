COUNT=$(checkupdates | wc -l);

if [[ "$COUNT" -ne 0 ]]; then
	printf "📦 %d update(s)\n" "$COUNT"
fi
