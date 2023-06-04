using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class FireEffect : MonoBehaviour
{
    
    // Start is called before the first frame update
    void Start()
    {
        
    }

    // Update is called once per frame
    void Update()
    {
        
    }

    void OnEnable()
    {
        StartCoroutine(Disable(0.1f));
    }

    IEnumerator Disable(float delay)
    {
        yield return new WaitForSeconds(delay);
        gameObject.SetActive(false);
        
    }
}
