import 'package:flutter/material.dart';

class HomepageAppBarAvatar extends StatelessWidget {
  const HomepageAppBarAvatar({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
            minimum: const EdgeInsets.only(right: 20.0),
            child: CircleAvatar(
              radius: 25.0,
              child: ClipOval(
                child: Image.network(
                'https://images-wixmp-ed30a86b8c4ca887773594c2.wixmp.com/f/d7bb2733-7dfe-4330-8419-84b38b2319fd/d5sey10-a2f1faa7-7922-4e95-9acf-7b6ccc8ce2e8.png?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJ1cm46YXBwOjdlMGQxODg5ODIyNjQzNzNhNWYwZDQxNWVhMGQyNmUwIiwiaXNzIjoidXJuOmFwcDo3ZTBkMTg4OTgyMjY0MzczYTVmMGQ0MTVlYTBkMjZlMCIsIm9iaiI6W1t7InBhdGgiOiJcL2ZcL2Q3YmIyNzMzLTdkZmUtNDMzMC04NDE5LTg0YjM4YjIzMTlmZFwvZDVzZXkxMC1hMmYxZmFhNy03OTIyLTRlOTUtOWFjZi03YjZjY2M4Y2UyZTgucG5nIn1dXSwiYXVkIjpbInVybjpzZXJ2aWNlOmZpbGUuZG93bmxvYWQiXX0.mXiPJsnOJ5HvEXgpC3j3Z1mwdq8zzXKYNt1kXer-TaM',
                ),
              ),
            ),
          );
  }
}