def check_valid(passphrase_list):
    valid_passphrases = []
    for passphrase in passphrase_list:
        words = passphrase.split(' ')
        if is_valid_passphrase(words):
            valid_passphrases.append(passphrase)

    return len(valid_passphrases)

def is_valid_passphrase(words):
    new_words = [''.join(sorted(w)) for w in words]
    return len(new_words) == len(set(new_words))

